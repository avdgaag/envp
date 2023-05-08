# frozen_string_literal: true

require "test_helper"
require "envp/vars/default_value"

module Envp
  module Vars
    class TestDefaultValue < Minitest::Test
      def test_has_a_name
        var = DefaultValue.new(Base.new("foo"), "x")
        assert_equal "foo", var.name
      end

      def test_returns_ok_result_of_reading_key_from_given_env
        var = DefaultValue.new(Base.new("foo"), "x")
        assert_equal({ ok: "bar" }, var.from("foo" => "bar"))
      end

      def test_returns_ok_result_of_default_value_when_value_is_nil
        var = DefaultValue.new(Base.new("foo"), "x")
        assert_equal({ ok: "x" }, var.from("foo" => nil))
      end
    end
  end
end
