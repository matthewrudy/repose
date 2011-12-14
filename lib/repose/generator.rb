module Repose
  class Generator
    def self.create_blank(path)
      File.open(path, "w") do |file|
        file.puts(File.read(File.dirname(__FILE__)+"/generator/Reposefile"))
      end
    end
  end
end
