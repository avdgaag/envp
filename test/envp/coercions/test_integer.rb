# frozen_string_literal: true

require "test_helper"
require "envp/coercions/integer"

module Envp
  module Coercions
    class TestInteger < Minitest::Test
      def setup
        @registry = Registry.default
      end

      def test_raises_on_invalid_value
        assert_raises { @registry.coerce(Integer, "") }
        assert_raises { @registry.coerce(Integer, "foo") }
        assert_raises { @registry.coerce(Integer, nil) }
        assert_raises { @registry.coerce(Integer, "123.45") }
      end

      def test_parses_integer_values
        assert_equal 123, @registry.coerce(Integer, "123")
      end
    end
  end
end
