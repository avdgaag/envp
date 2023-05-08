# frozen_string_literal: true

require "test_helper"
require "env_parser/coercions/registry"
require "env_parser/coercions/integer"
require "env_parser/vars/coerced"

module EnvParser
  module Vars
    class TestCoerced < Minitest::Test
      def test_has_a_name
        var = Coerced.new(Base.new("foo"), Integer, Coercions::Registry.default)
        assert_equal "foo", var.name
      end

      def test_returns_ok_with_coercion_result
        var = Coerced.new(Base.new("foo"), Integer, Coercions::Registry.default)
        assert_equal({ ok: 123 }, var.from("foo" => "123"))
      end

      def test_returns_error_when_coercion_fails
        var = Coerced.new(Base.new("foo"), Integer, Coercions::Registry.default)
        assert_equal({ error: "invalid value for Integer(): \"bar\"" }, var.from("foo" => "bar"))
      end
    end
  end
end
