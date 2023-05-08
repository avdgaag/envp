# frozen_string_literal: true

require "test_helper"

class TestEnvp < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Envp::VERSION
  end

  def test_it_parses_into_regular_hash
    result =
      Envp.parse(env: { "FOO" => "bar" }) do |e|
        e.required("FOO")
      end
    assert_equal({ "FOO" => "bar" }, result)
  end

  def test_it_parses_into_regular_symbolized_normalized_hash
    result =
      Envp.parse(env: { "FOO_BAR" => "bar" }, symbolize: true, normalize: true) do |e|
        e.required("FOO_BAR")
      end
    assert_equal({ foo_bar: "bar" }, result)
  end

  def test_raises_when_defining_constants_on_object
    scope = Object.new
    assert_raises do
      Envp.parse(env: { "FOO_BAR" => "bar" }, constants: scope) do |e|
        e.required("FOO_BAR")
      end
    end
  end

  def test_defines_constants_on_given_object
    scope = Class.new
    Envp.parse(env: { "FOO_BAR" => "bar" }, constants: scope) do |e|
      e.required("FOO_BAR")
    end
    assert_equal "bar", scope::FOO_BAR
  end

  def test_raises_summary_error_when_fetching_failed
    err = assert_raises Envp::Failure do
      Envp.parse(env: { "FOO" => "bla" }) do |e|
        e.required("FOO", Integer)
        e.required("BAR")
        e.optional("BAZ")
      end
    end
    assert_equal <<~MSG.chomp, err.message
      FOO: invalid value for Integer(): "bla"
      BAR: missing required value
    MSG
  end
end
