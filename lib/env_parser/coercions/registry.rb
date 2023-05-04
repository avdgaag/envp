# frozen_string_literal: true

module EnvParser
  module Coercions
    class Registry
      def self.default
        @default ||= new
      end

      def initialize
        @coercions = {}
      end

      def register(target, &block)
        @coercions[target] = block
      end

      def coerces?(target)
        @coercions.key?(target)
      end

      def coerce(target, value)
        @coercions.fetch(target).call(value)
      end
    end
  end
end
