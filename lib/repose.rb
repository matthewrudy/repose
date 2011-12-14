module Repose

  def self.define(&block)
    BaseNode.new(&block)
  end

  class Node

    def initialize(&block)
      @directories = []
      instance_eval(&block)
    end
    attr_reader :directories

    # directory "Rails" do
    #  repo "core", :git => "https://github.com/rails/rails.git"
    #  repo "my-fork", :git => "git@github.com:me/rails.git"
    # end
    def directory(path, &block)
      @directories << Directory.new(path, &block)
    end
  end

  class BaseNode < Node
  end

  class Directory < Node

    def initialize(path, &block)
      @path = path
      @repos = []
      super()
    end
    attr_reader :path, :repos

    def repo(name, options)
      @repos << Repository.new(name, options)
    end

  end

  class Repository

    def initialize(name, options)
      @name, @options = name, options
    end
    attr_reader :name

    def create
      GitCommand.clone(options[:git], @name)
    end

  end

  class GitCommand

    def self.clone(url, path)
      `git clone #{url} #{path}`
    end

  end
end
