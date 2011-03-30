class YARD::Handlers::Processor
  attr_accessor :extra_state
end

class ThorHandler < YARD::Handlers::Ruby::Base
  namespace_only
  handles method_call(:desc)
  
  process do
    parser.extra_state ||= {}
    parser.extra_state[:thor_desc] = statement.parameters(false).map do |param|
      param.jump(:string_content).source
    end
  end
end

module ThorMethodHandlerMixin
  def register(*objs)
    @registered_object = objs.first
    super(*objs)
  end
  
  def process
    super
    return if parser.extra_state[:thor_desc].nil?
    params, desc = *parser.extra_state[:thor_desc]
    @registered_object.docstring = desc
    @registered_object.signature = params
    @registered_object.namespace.groups = ["Thor Commands"]
    @registered_object.group = "Thor Commands"
    @registered_object.docstring.add_tag YARD::Tags::Tag.new(:thor_command, '')
    parser.extra_state.delete(:thor_desc)
  end
end

class YARD::Handlers::Ruby::MethodHandler 
  include ThorMethodHandlerMixin
end

module BetterSignature
end

module YARD::Templates::Helpers::HtmlHelper
  alias old_signature signature
  def signature(meth, link = true, *args)
    if meth.has_tag?(:thor_command)
      sig = link ? link_object(meth, meth.signature) : meth.signature
      "$ " + sig 
    else
      old_signature(meth, link, *args)
    end
  end
  include BetterSignature
end
