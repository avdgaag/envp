# frozen_string_literal: true

require "forwardable"
require_relative "../errors"

module Envp
  module Coercions
    class Registry
      extend Forwardable
      def_delegator :@coercions, :empty?
      def_delegator :@coercions, :key?, :coerces?

      def self.default
        @default ||= new
      end

      def initialize
        @coercions = {}
      end

      def register(target, &block)
        @coercions[target] = block
      end

      def coerce(target, value)
        raise UnknownCoercion unless coerces?(target)

        @coercions.fetch(target).call(value)
      end
    end
  end
end
