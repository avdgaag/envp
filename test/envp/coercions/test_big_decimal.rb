# frozen_string_literal: true

require "test_helper"
require "envp/coercions/big_decimal"

module Envp
  module Coercions
    class TestBigDecimal < Minitest::Test
      def setup
        @registry = Registry.default
      end

      def test_raises_on_invalid_value
        assert_raises { @registry.coerce(BigDecimal, "") }
        assert_raises { @registry.coerce(BigDecimal, "foo") }
        assert_raises { @registry.coerce(BigDecimal, nil) }
      end

      def test_parses_decimal_values
        assert_equal BigDecimal("2.95"), @registry.coerce(BigDecimal, "2.95")
      end
    end
  end
end
