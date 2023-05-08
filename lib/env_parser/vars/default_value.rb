# frozen_string_literal: true

require "delegate"
require_relative "base"
require_relative "../result"

module EnvParser
  module Vars
    # A `Var` that provides a default value when the value read from the
    # environment is `nil`.
    class DefaultValue < DelegateClass(Base)
      # @param var [Base]
      # @param default [Object] the default value to return.
      def initialize(var, default)
        super(var)
        @default = default
      end

      def from(env)
        Result.map(__getobj__.from(env)) do |value|
          value || @default
        end
      end
    end
  end
end
