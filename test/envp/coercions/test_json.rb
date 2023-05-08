# frozen_string_literal: true

require "test_helper"
require "envp/coercions/json"

module Envp
  module Coercions
    class TestJson < Minitest::Test
      def setup
        @registry = Registry.default
      end

      def test_raises_on_invalid_json
        assert_raises do
          @registry.coerce(JSON, '{"')
        end
      end

      def test_parses_valid_json_values
        assert_equal({ "foo" => "bar" }, @registry.coerce(JSON, '{"foo":"bar"}'))
      end
    end
  end
end
