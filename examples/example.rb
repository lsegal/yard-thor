class MyApp
  include CLI

  desc "list [list]", "list some items"
  def list(list = "stuff")
    puts list.split(/,\s*/).join("\n")
  end
  
  desc "delete <filename>", "Delete a file!"
  def delete(filename)
    File.unlink(filename)
  end
  
  # Documentation for utility method
  def utility_method
  end
end

MyApp.start
