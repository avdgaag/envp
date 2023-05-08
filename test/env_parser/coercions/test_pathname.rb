# frozen_string_literal: true

require "test_helper"
require "env_parser/coercions/pathname"

module EnvParser
  module Coercions
    class TestPathname < Minitest::Test
      def setup
        @registry = Registry.default
      end

      def test_raises_on_invalid_value
        assert_raises { @registry.coerce(Pathname, nil) }
      end

      def test_parses_pathnames_from_strings
        assert_equal Pathname.new("foo"), @registry.coerce(Pathname, "foo")
      end
    end
  end
end
