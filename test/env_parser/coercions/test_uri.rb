# frozen_string_literal: true

require "test_helper"
require "env_parser/coercions/regexp"

module EnvParser
  module Coercions
    class TestURI < Minitest::Test
      def setup
        @registry = Registry.default
      end

      def test_raises_on_invalid_value
        assert_raises { @registry.coerce(URI, nil) }
      end

      def test_parses_uri_values
        assert_equal(URI("http://example.com"), @registry.coerce(URI, "http://example.com"))
      end
    end
  end
end
