require 'repose/definition'
require 'repose/dsl'
require 'repose/version'

module Repose

  def self.define(&block)
    ::Repose::Definition.new(&block)
  end

end
