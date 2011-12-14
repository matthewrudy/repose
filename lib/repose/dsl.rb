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

      private # DSL methods should be private

      def repo(name, options)
        @repos << Repository.new(name, options)
      end

    end

    class Repository

      def initialize(name, options)
        @name, @options = name, options
      end
      attr_reader :name

    end
  end
end