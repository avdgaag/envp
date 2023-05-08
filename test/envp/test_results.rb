# frozen_string_literal: true

require "test_helper"
require "envp/results"

module Envp
  class TestResults < Minitest::Test
    def test_starts_empty
      assert_empty Results.new
    end

    def test_writes_and_reads_value
      results = Results.new
      results[:a] = "b"
      assert_equal "b", results[:a]
    end

    def test_accumulates_ok_values
      results = Results.new
      results[:a] = { ok: "a" }
      results[:b] = { ok: "b" }
      assert_equal({ ok: { "a" => "a", "b" => "b" } }, results.result)
    end

    def test_accumulates_error_values
      results = Results.new
      results[:a] = { ok: "a" }
      results[:b] = { error: "b" }
      results[:c] = { error: "c" }
      assert_equal({ error: { "b" => "b", "c" => "c" } }, results.result)
    end
  end
end
