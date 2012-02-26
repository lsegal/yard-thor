# -*- encoding: utf-8 -*-
Gem::Specification.new do |gem|
  gem.authors               = ["Loren Segal"]
  gem.email                 = ["lsegal@soen.ca"]
  gem.description           = %q{Thor plugin for YARD}
  gem.summary               = %q{A plugin for YARD, a documentation system. With this plugin, YARD will pick up documentation automatically from the Thor DSL.}
  gem.homepage              = "http://github.com/lsegal/yard-thor"
  #gem.license               = "MIT"
  gem.required_ruby_version = ">= 1.8.7"
  gem.version               = "0.2"

  gem.executables           = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files                 = `git ls-files`.split("\n")
  gem.test_files            = `git ls-files -- {examples,test,spec,features}/*`.split("\n")
  gem.name                  = "yard-thor"
  gem.require_paths         = ["lib"]

  gem.add_dependency('yard')

  gem.add_development_dependency('rake')
end
