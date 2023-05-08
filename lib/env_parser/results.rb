# frozen_string_literal: true

require "forwardable"
require_relative "result"

module EnvParser
  # A container for parsing results. Each known var is combined with a Result
  # value. It then provides a single Result value representing either the
  # successful parsings, or, if there are error values, all errors.
  class Results
    extend Forwardable

    def_delegators :@vars, :empty?, :[], :[]=

    # @param vars [Hash<EnvParser::Vars::Base, Hash<Symbol, Object>>]
    def initialize(vars = {})
      @vars = vars
    end

    # A single Result value for all ok vars or all error vars.
    #
    # @see EnvParser::Result
    # @return [Hash<Symbol, Hash<String, Object>>]
    def result
      @vars.inject(Result.ok({})) do |acc, (key, value)|
        case [acc, value]
        in [{ok: _}, { error: error }]
          Result.error(key.name => error)
        in [{error: hash}, {error: error}]
          Result.error(hash.merge(key.name => error))
        in [{ok: hash}, {ok: value}]
          Result.ok(hash.merge(key.name => value))
        in [{error: _}, {ok: _}]
          acc
        end
      end
    end
  end
end
