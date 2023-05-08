# frozen_string_literal: true

require "test_helper"
require "env_parser/coercions/float"

module EnvParser
  module Coercions
    class TestFloat < Minitest::Test
      def setup
        @registry = Registry.default
      end

      def test_raises_on_invalid_value
        assert_raises { @registry.coerce(Float, "") }
        assert_raises { @registry.coerce(Float, "foo") }
        assert_raises { @registry.coerce(Float, nil) }
      end

      def test_parses_float_values
        assert_equal 20.3, @registry.coerce(Float, "20.3")
      end
    end
  end
end
