# frozen_string_literal: true

require "test_helper"
require "env_parser/coercions/bool"

module EnvParser
  module Coercions
    class TestBool < Minitest::Test
      def setup
        @registry = Registry.default
      end

      def test_parses_bool_values
        assert_equal false, @registry.coerce(:bool, nil)
        assert_equal false, @registry.coerce(:bool, "foo")
        assert_equal true, @registry.coerce(:bool, "1")
        assert_equal true, @registry.coerce(:bool, "true")
      end
    end
  end
end
