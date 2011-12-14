module Repose
  module DSL
    class Node

      def initialize(&block)
        @directories = []
        instance_eval(&block)
      end
      attr_reader :directories

      private # DSL methods should be private

      # directory "Rails" do
      #  git "core", :url => "https://github.com/rails/rails.git"
      #  git "my-fork", :git => "git@github.com:me/rails.git"
      # end
      def directory(path, &block)
        @directories << Directory.new(path, self, &block)
      end
    end

    class BaseNode < Node
      def full_path
        "."
      end
    end

    class Directory < Node

      def initialize(path, parent=nil, &block)
        @path = path
        @parent = parent
        @repos = []
        super()
      end
      attr_reader :path, :parent, :repos

      def parent_path
        parent && parent.full_path
      end

      def full_path
        File.join([parent_path, path].compact)
      end


      private # DSL methods should be private

      # the git repository type
      def git(name, options)
        add_repository(GitRepository, name, options)
      end

      def add_repository(klass, name, options)
        @repos << klass.new(name, options.merge(:directory => self))
      end

    end

    class Repository

      def initialize(name, options)
        @name, @options = name, options
      end
      attr_reader :name

      def url
        @options[:url]
      end

      def directory
        @options[:directory]
      end

      def full_path
        File.join(directory.full_path, name)
      end

    end

    class GitRepository < Repository
    end

  end
end