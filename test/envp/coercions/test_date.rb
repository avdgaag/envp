# frozen_string_literal: true

require "test_helper"
require "envp/coercions/date"

module Envp
  module Coercions
    class TestDate < Minitest::Test
      def setup
        @registry = Registry.default
      end

      def test_raises_on_invalid_value
        assert_raises { @registry.coerce(Date, "") }
        assert_raises { @registry.coerce(Date, "foo") }
        assert_raises { @registry.coerce(Date, nil) }
      end

      def test_parses_date_values
        assert_equal Date.new(2020, 3, 21), @registry.coerce(Date, "2020-03-21")
      end
    end
  end
end
