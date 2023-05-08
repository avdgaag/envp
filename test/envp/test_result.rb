# frozen_string_literal: true

require "test_helper"
require "envp/result"

module Envp
  class TestResult < Minitest::Test
    def test_ok
      assert_equal({ ok: "a" }, Result.ok("a"))
    end

    def test_error
      assert_equal({ error: "a" }, Result.error("a"))
    end

    def test_map_transforms_ok_value
      result = Result.ok("a")
      assert_equal({ ok: "A" }, Result.map(result, &:upcase))
    end

    def test_map_does_not_alter_error_value
      result = Result.error("a")
      assert_equal({ error: "a" }, Result.map(result, &:upcase))
    end

    def test_map_raises_when_given_non_result_value
      assert_raises do
        Result.map(:other)
      end
    end

    def test_map_error_transforms_error_value
      result = Result.error("a")
      assert_equal({ error: "A" }, Result.map_error(result, &:upcase))
    end

    def test_map_error_does_not_alter_ok_value
      result = Result.ok("a")
      assert_equal({ ok: "a" }, Result.map_error(result, &:upcase))
    end

    def test_map_error_raises_when_given_non_result_value
      assert_raises do
        Result.map(:other)
      end
    end

    def test_then_yields_for_ok_values
      result = Result.ok("a")
      assert_equal({ ok: "ab" }, Result.then(result) { { ok: "#{_1}b" } })
    end

    def test_then_does_not_yield_for_error_values
      result = Result.error("a")
      assert_equal({ error: "a" }, Result.then(result) { { ok: "#{_1}b" } })
    end

    def test_then_raises_when_given_non_result_value
      assert_raises do
        Result.then(:other)
      end
    end
  end
end
