# frozen_string_literal: true

require "test_helper"
require "env_parser/coercions/registry"

module EnvParser
  module Coercions
    class TestRegistry < Minitest::Test
      def test_starts_empty
        registry = Registry.new
        assert_empty registry
      end

      def test_default_returns_same_registry_every_time
        registry1 = Registry.default
        registry2 = Registry.default
        assert_equal registry1, registry2
      end

      def test_registers_new_coercions
        registry = Registry.new
        registry.register(Integer) { _1 + 1 }
        refute_empty registry
      end

      def test_applies_coercion
        registry = Registry.new
        registry.register(Integer) { _1 + 1 }
        assert_equal 2, registry.coerce(Integer, 1)
      end

      def test_indicates_whether_it_can_coerce_to_target
        registry = Registry.new
        registry.register(Integer) { _1 + 1 }
        assert registry.coerces?(Integer)
        refute registry.coerces?(Float)
      end

      def test_raises_when_coercion_can_not_be_found
        registry = Registry.new
        assert_raises UnknownCoercion do
          registry.coerce(Integer, 1)
        end
      end
    end
  end
end
