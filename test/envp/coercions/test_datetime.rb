# frozen_string_literal: true

require "test_helper"
require "envp/coercions/datetime"

module Envp
  module Coercions
    class TestDateTime < Minitest::Test
      def setup
        @registry = Registry.default
      end

      def test_raises_on_invalid_value
        assert_raises { @registry.coerce(DateTime, "") }
        assert_raises { @registry.coerce(DateTime, "foo") }
        assert_raises { @registry.coerce(DateTime, nil) }
      end

      def test_parses_datetime_values
        assert_equal DateTime.new(2020, 3, 21, 12, 31, 0), @registry.coerce(DateTime, "2020-03-21 12:31:00")
      end
    end
  end
end
