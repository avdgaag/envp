# frozen_string_literal: true

require_relative "../result"

module EnvParser
  module Vars
    # A base specification for an environment variable to read.
    class Base
      # @return [String]
      attr_reader :name

      # @param name [String] name of the variable the read
      def initialize(name)
        @name = name
      end

      # Read the named variable from the given hash-like value.
      #
      # @param env [#to_h]
      # @return [Hash<Symbol, Object>]
      def from(env)
        Result.ok(env.to_h[@name])
      end
    end
  end
end
