require 'repose/dsl'
require 'repose/version'

module Repose

  def self.define(&block)
    ::Repose::DSL::BaseNode.new(&block)
  end

end
