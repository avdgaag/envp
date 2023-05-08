# frozen_string_literal: true

require "test_helper"
require "envp/coercions/datetime"

module Envp
  module Coercions
    class TestTime < Minitest::Test
      def setup
        @registry = Registry.default
      end

      def test_raises_on_invalid_value
        assert_raises { @registry.coerce(Time, "") }
        assert_raises { @registry.coerce(Time, "foo") }
        assert_raises { @registry.coerce(Time, nil) }
      end

      def test_parses_time_values
        assert_equal Time.new(2020, 3, 21, 12, 31, 0), @registry.coerce(Time, "2020-03-21 12:31:00")
      end
    end
  end
end
