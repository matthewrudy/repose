module Repose
  class Definition

    def initialize(&block)
      @dsl = ::Repose::DSL::BaseNode.new(&block)
    end
    attr_reader :dsl

  end
end