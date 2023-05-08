# frozen_string_literal: true

require_relative "envp/version"
require_relative "envp/parser"
require_relative "envp/errors"

module Envp
  # @param env [#to_h] (defaults to `ENV`)
  # @param constants [Boolean, Object] whether to define constants for the
  #   loaded environment variables. When `true`, constants are defined on the
  #   `Envp` module. If any other object, that will be used to define
  #   constants in. Defaults to `false`.
  # @param symbolize [Boolean] whether to transform loaded environment variables
  #   to symbols in the returned result. Defaults to `false`.
  # @param normalize [Boolean] whether to rename loaded environment variables
  #   from UPPER_SNAKE_CASE to lower_snake_case. Defaults to `false`.
  # @raise [Failure]
  # @return [Hash]
  def self.parse(env: ENV, constants: false, symbolize: false, normalize: false)
    parser = Parser.new
    yield parser
    case parser.parse(env).result
    in { ok: results }
      handle_ok(results, constants, symbolize, normalize)
    in { error: errors }
      handle_errors(errors)
    end
  end

  def self.handle_ok(results, constants, symbolize, normalize)
    if constants == true
      define_constants(Envp, results)
    elsif constants.respond_to?(:const_set)
      define_constants(constants, results)
    elsif constants
      raise "Cannot define new constants on #{constants.inspect}"
    end
    results = results.transform_keys(&:downcase) if normalize
    results = results.transform_keys(&:to_sym) if symbolize
    results
  end

  private_class_method :handle_ok

  def self.handle_errors(errors)
    msg = errors.map { |key, value| "#{key}: #{value}" }
    raise Failure, msg.join("\n")
  end

  private_class_method :handle_errors

  def self.define_constants(obj, results)
    results.each do |key, value|
      obj.const_set(key, value)
    end
  end

  private_class_method :define_constants
end
