# frozen_string_literal: true

require "test_helper"
require "env_parser/coercions/regexp"

module EnvParser
  module Coercions
    class TestString < Minitest::Test
      def setup
        @registry = Registry.default
      end

      def test_parses_string_values
        assert_equal "", @registry.coerce(String, nil)
        assert_equal "foo", @registry.coerce(String, "foo")
      end
    end
  end
end
