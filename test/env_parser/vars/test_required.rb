# frozen_string_literal: true

require "test_helper"
require "env_parser/vars/required"

module EnvParser
  module Vars
    class TestRequired < Minitest::Test
      def test_has_a_name
        var = Required.new(Base.new("foo"))
        assert_equal "foo", var.name
      end

      def test_returns_ok_result_of_reading_key_from_given_env
        var = Required.new(Base.new("foo"))
        assert_equal({ ok: "bar" }, var.from("foo" => "bar"))
      end

      def test_returns_error_result_when_nil
        var = Required.new(Base.new("foo"))
        assert_equal({ error: "missing required value" }, var.from("foo" => nil))
      end

      def test_returns_error_result_when_not_present
        var = Required.new(Base.new("foo"))
        assert_equal({ error: "missing required value" }, var.from({}))
      end
    end
  end
end
