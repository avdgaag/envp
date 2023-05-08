# frozen_string_literal: true

module Envp
  # Work with special values representing successful and unsuccessful
  # operations.
  module Result
    # Tag a value as being a failed result.
    #
    # @param value [Object]
    # @return [Hash<Symbol, Object>]
    def self.error(value)
      { error: value }
    end

    # Tag a value as being a succesful result.
    #
    # @param value [Object]
    # @return [Hash<Symbol, Object>]
    def self.ok(value)
      { ok: value }
    end

    # Apply a block to an ok-value, ignoring error-values.
    #
    # @param result [Hash<Symbol, Object>]
    # @yield value [Object]
    # @return [Hash<Symbol, Object>]
    def self.map(result)
      case result
      in {ok: value}
        ok(yield(value))
      in {error: _}
        result
      end
    end

    # Apply a block to an error-value, ignoring ok-values.
    #
    # @param result [Hash<Symbol, Object>]
    # @yield value [Object]
    # @return [Hash<Symbol, Object>]
    def self.map_error(result)
      case result
      in {ok: _}
        result
      in {error: err}
        error(yield(err))
      end
    end

    # Chain a block returning a result value to a result value.
    #
    # @param result [Hash<Symbol, Object>]
    # @yield value [Object]
    # @return [Hash<Symbol, Object>]
    def self.then(result)
      case result
      in {ok: value}
        yield(value)
      in {error: _}
        result
      end
    end
  end
end
