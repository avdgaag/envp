# frozen_string_literal: true

require "test_helper"
require "envp/vars/non_blank"

module Envp
  module Vars
    class TestNonBlank < Minitest::Test
      def test_has_a_name
        var = NonBlank.new(Base.new("foo"))
        assert_equal "foo", var.name
      end

      def test_returns_ok_result_of_reading_key_from_given_env
        var = NonBlank.new(Base.new("foo"))
        assert_equal({ ok: "bar" }, var.from("foo" => "bar"))
      end

      def test_returns_error_result_when_nil
        var = NonBlank.new(Base.new("foo"))
        assert_equal({ error: "disallowed blank value" }, var.from("foo" => nil))
      end

      def test_returns_error_result_when_empty_string
        var = NonBlank.new(Base.new("foo"))
        assert_equal({ error: "disallowed blank value" }, var.from("foo" => ""))
      end

      def test_returns_error_result_when_blank_string
        var = NonBlank.new(Base.new("foo"))
        assert_equal({ error: "disallowed blank value" }, var.from("foo" => "  "))
      end
    end
  end
end
