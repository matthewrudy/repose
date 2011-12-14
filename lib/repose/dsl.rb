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

      private # DSL methods should be private

      # the git repository type
      def git(name, options)
        add_repository(GitRepository, name, options)
      end

      def add_repository(klass, name, options)
        @repos << klass.new(name, options)
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

    end

    class GitRepository < Repository
    end

  end
end