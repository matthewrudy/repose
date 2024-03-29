require 'fileutils'

module Repose
  module DSL
    class Node

      def initialize(&block)
        @directories = []
        instance_eval(&block)
      end
      attr_reader :directories

      # go through each directory yield it, then recurse
      def each_node(&block)
        directories.each do |d|
          block.call(d)
          d.each_node(&block)
        end
      end

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

      def install(base_path)
        #noop
      end

      def update(base_path)
        #noop
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

      def full_path(base_path=nil)
        File.join([base_path, parent_path, path].compact)
      end

      def install(base_path)
        create!(base_path)
      end

      def update(base_path)
        create!(base_path)
      end

      def each_node(&block)
        super(&block)
        repos.each do |r|
          block.call(r)
        end
      end

      protected

      def create!(base_path)
        expanded_path = full_path(base_path)
        if File.exist?(expanded_path)
          if File.directory?(expanded_path)
            puts "path exists: #{expanded_path}" if Repose.verbose
            # all is good
          else
            raise "#{expanded_path} already exists, but is not a directory"
          end
        else
          FileUtils.mkdir_p(expanded_path)
          puts "path created: #{expanded_path}" if Repose.verbose
        end
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

      def full_path(base_path=nil)
        File.join(directory.full_path(base_path), name)
      end

    end

    class GitRepository < Repository

      def install(base_path)
        clone_command = "git clone #{url} #{full_path(base_path)}"
        puts clone_command if Repose.verbose
        system(clone_command)
      end

      def update(base_path)
        `cd #{full_path(base_path)} && git pull origin`
      end
    end

  end
end