module Repose
  class Definition

    def initialize(&block)
      @dsl = ::Repose::DSL::BaseNode.new(&block)
    end
    attr_reader :dsl

    def install(base_path)
      dsl.each_node do |node|
        node.install(base_path)
      end
    end

  end
end