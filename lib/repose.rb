require 'repose/definition'
require 'repose/dsl'
require 'repose/generator'
require 'repose/version'

module Repose

  def self.define(&block)
    ::Repose::Definition.new(&block)
  end

  def self.from_file(file)
    eval <<-EVAL

      Repose.define do
        #{file.read}
      end

    EVAL
  end

  @@VERBOSE = false

  def self.verbose
    @@VERBOSE
  end

  def self.verbose=(value)
    @@VERBOSE=value
  end

end
