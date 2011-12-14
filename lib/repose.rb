module Repose

  class Base

    def initialize
      @directories = []
    end
    attr_reader :directories

    def self.define(&block)
      self.new().tap do |base|
        base.instance_eval(&block)
      end
    end

    # directory "Rails" do
    #  repo "core", :git => "https://github.com/rails/rails.git"
    #  repo "my-fork", :git => "git@github.com:me/rails.git"
    # end
    def directory(path, &block)
      @directories << Directory.new(path, &block)
    end

  end

  class Directory

    def initialize(path, &block)
      @path = path
      @repos = []

      instance_eval(&block)
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
