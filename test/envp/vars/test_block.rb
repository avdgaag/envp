# frozen_string_literal: true

require "test_helper"
require "envp/vars/block"

module Envp
  module Vars
    class TestBlock < Minitest::Test
      def test_has_a_name
        var = Block.new(Base.new("foo"), &:upcase)
        assert_equal "foo", var.name
      end

      def test_returns_ok_result_of_reading_key_from_given_env_and_applying_block
        var = Block.new(Base.new("foo"), &:upcase)
        assert_equal({ ok: "BAR" }, var.from("foo" => "bar"))
      end
    end
  end
end
