# frozen_string_literal: true

require "test_helper"
require "env_parser/coercions/symbol"

module EnvParser
  module Coercions
    class TestSymbol < Minitest::Test
      def setup
        @registry = Registry.default
      end

      def test_parses_valid_symbol_values
        assert_equal(:bar, @registry.coerce(Symbol, 'bar'))
      end
    end
  end
end
