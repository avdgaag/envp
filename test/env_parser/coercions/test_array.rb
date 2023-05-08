# frozen_string_literal: true

require "test_helper"
require "env_parser/coercions/array"

module EnvParser
  module Coercions
    class TestArray < Minitest::Test
      def setup
        @registry = Registry.default
      end

      def test_splits_empty_string_to_empty_array
        assert_equal [], @registry.coerce(Array, "")
      end

      def test_splits_non_empty_string_to_one_element_array
        assert_equal ["foo"], @registry.coerce(Array, "foo")
      end

      def test_splits_csv_string_to_array
        assert_equal %w[foo bar], @registry.coerce(Array, "foo,bar")
      end

      def test_trims_whitespace_when_splitting
        assert_equal %w[foo bar], @registry.coerce(Array, "foo , bar")
      end

      def test_treats_nil_values_as_empty_string
        assert_equal [], @registry.coerce(Array, nil)
      end
    end
  end
end
