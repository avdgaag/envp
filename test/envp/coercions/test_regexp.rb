# frozen_string_literal: true

require "test_helper"
require "envp/coercions/regexp"

module Envp
  module Coercions
    class TestRegexp < Minitest::Test
      def setup
        @registry = Registry.default
      end

      def test_raises_on_invalid_value
        assert_raises { @registry.coerce(Regexp, nil) }
      end

      def test_parses_regexp_values
        assert_equal(/foo/, @registry.coerce(Regexp, "foo"))
        assert_equal(/a|b$/, @registry.coerce(Regexp, "a|b$"))
      end
    end
  end
end
