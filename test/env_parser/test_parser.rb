# frozen_string_literal: true

require "test_helper"
require "env_parser/parser"
require "env_parser/coercions/all"

module EnvParser
  class TestParser < Minitest::Test
    parallelize_me!

    def setup
      @parser = Parser.new
    end

    def test_does_nothing_when_no_vars_have_been_specified
      env = {}
      assert_equal({ ok: {} }, @parser.parse(env).result)
    end

    def test_loads_only_specified_vars_from_env
      env = { "FOO" => "bar", "BAZ" => "qux" }
      @parser.required("FOO")
      assert_equal({ ok: { "FOO" => "bar" } }, @parser.parse(env).result)
    end

    def test_loads_optional_vars_from_env_if_present
      env = { "FOO" => "bar" }
      @parser.optional("FOO")
      assert_equal({ ok: { "FOO" => "bar" } }, @parser.parse(env).result)
    end

    def test_uses_nil_when_optional_var_is_not_present
      env = {}
      @parser.optional("FOO")
      assert_equal({ ok: { "FOO" => nil } }, @parser.parse(env).result)
    end

    def test_can_use_custom_default_if_missing_optional_is_missing
      env = {}
      @parser.optional("FOO", default: "bla")
      assert_equal({ ok: { "FOO" => "bla" } }, @parser.parse(env).result)
    end

    def test_returns_error_when_required_var_is_not_set
      env = {}
      @parser.required("FOO")
      assert_equal({ error: { "FOO" => "missing required value" } }, @parser.parse(env).result)
    end

    def test_loads_required_var_as_empty_string
      env = { "FOO" => "" }
      @parser.required("FOO")
      assert_equal({ ok: { "FOO" => "" } }, @parser.parse(env).result)
    end

    def test_returns_error_when_required_var_does_not_allow_blank
      env = { "FOO" => "" }
      @parser.required("FOO", allow_blank: false)
      assert_equal({ error: { "FOO" => "disallowed blank value" } }, @parser.parse(env).result)
    end

    def test_fetched_values_are_passed_through_block_if_given
      env = { "FOO" => "bar" }
      @parser.required("FOO", &:upcase)
      assert_equal({ ok: { "FOO" => "BAR" } }, @parser.parse(env).result)
    end

    def test_coerces_value_to_integer
      env = { "FOO" => "123" }
      @parser.required("FOO", Integer)
      assert_equal({ ok: { "FOO" => 123 } }, @parser.parse(env).result)
    end

    def test_coerces_value_to_big_decimal
      env = { "FOO" => "123.4" }
      @parser.required("FOO", BigDecimal)
      assert_equal({ ok: { "FOO" => BigDecimal("123.4") } }, @parser.parse(env).result)
    end

    def test_coerces_value_to_float
      env = { "FOO" => "123.4" }
      @parser.required("FOO", Float)
      assert_equal({ ok: { "FOO" => 123.4 } }, @parser.parse(env).result)
    end

    def test_coerces_value_to_pathname
      env = { "FOO" => "foo" }
      @parser.required("FOO", Pathname)
      assert_equal({ ok: { "FOO" => Pathname("foo") } }, @parser.parse(env).result)
    end

    def test_coerces_value_to_date
      env = { "FOO" => "2020-01-01" }
      @parser.required("FOO", Date)
      assert_equal({ ok: { "FOO" => Date.new(2020, 1, 1) } }, @parser.parse(env).result)
    end

    def test_coerces_value_to_time
      env = { "FOO" => "2020-01-01 12:00" }
      @parser.required("FOO", Time)
      assert_equal({ ok: { "FOO" => Time.new(2020, 1, 1, 12, 0, 0) } }, @parser.parse(env).result)
    end

    def test_coerces_value_to_datetime
      env = { "FOO" => "2020-01-01 12:00" }
      @parser.required("FOO", DateTime)
      assert_equal({ ok: { "FOO" => DateTime.new(2020, 1, 1, 12, 0, 0) } }, @parser.parse(env).result)
    end

    def test_coerces_value_to_uri
      env = { "FOO" => "http://example.com" }
      @parser.required("FOO", URI)
      assert_equal({ ok: { "FOO" => URI.parse("http://example.com") } }, @parser.parse(env).result)
    end

    def test_coerces_value_to_array
      env = { "FOO" => "a,b,c" }
      @parser.required("FOO", Array)
      assert_equal({ ok: { "FOO" => %w[a b c] } }, @parser.parse(env).result)
    end

    def test_coerces_value_to_regexp
      env = { "FOO" => "a|b" }
      @parser.required("FOO", Regexp)
      assert_equal({ ok: { "FOO" => /a|b/ } }, @parser.parse(env).result)
    end

    def test_supports_custom_coercions
      env = { "FOO" => "bar" }
      @parser.accept(Hash) { { foo: _1 } }
      @parser.required("FOO", Hash)
      assert_equal({ ok: { "FOO" => { foo: "bar" } } }, @parser.parse(env).result)
    end

    def test_returns_error_when_coercion_fails
      env = { "FOO" => "bla" }
      @parser.required("FOO", Integer)
      assert_equal({ error: { "FOO" => "invalid value for Integer(): \"bla\"" } }, @parser.parse(env).result)
    end

    def test_passes_value_through_block_after_coercion
      env = { "FOO" => "123" }
      @parser.required("FOO", Integer) { _1 + 3 }
      assert_equal({ ok: { "FOO" => 126 } }, @parser.parse(env).result)
    end

    def test_collects_all_errors
      env = { "FOO" => "x", "BAR" => "y" }
      @parser.required("FOO", Integer)
      @parser.optional("BAR", Integer)
      assert_equal(
        { error: { "FOO" => "invalid value for Integer(): \"x\"",
                   "BAR" => "invalid value for Integer(): \"y\"" } }, @parser.parse(env).result
      )
    end
  end
end
