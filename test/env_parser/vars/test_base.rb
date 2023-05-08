# frozen_string_literal: true

require "test_helper"
require "env_parser/vars/base"

module EnvParser
  module Vars
    class TestBase < Minitest::Test
      def test_has_a_name
        var = Base.new("foo")
        assert_equal "foo", var.name
      end

      def test_returns_ok_result_of_reading_key_from_given_env
        var = Base.new("foo")
        assert_equal({ ok: "bar" }, var.from("foo" => "bar"))
      end
    end
  end
end
