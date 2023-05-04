# frozen_string_literal: true

module EnvParser
  class Result
    def self.error?(value)
      case value
      in {error: _}
        true
      else
        false
      end
    end

    def self.error(value)
      { error: value }
    end

    def self.ok(value)
      { ok: value }
    end

    def self.map(result)
      case result
      in {ok: value}
        ok(yield(value))
      in {error: err}
        result
      end
    end

    def self.map_error(result)
      case result
      in {ok: value}
        result
      in {error: err}
        error(yield(value))
      end
    end

    # def self.map2(result1, result2)
    #   case [result1, result2]
    #   in [{ok: value1}, {ok: value2}]
    #     ok(yield value1, value2)
    #   in [{ok: _}, {error: _}]
    #     result2
    #   in [{error: _}, {ok: _}]
    #     result1
    #   in [{error: _}, {error: _}]
    #     result1
    #   end
    # end

    def self.then(result)
      case result
      in {ok: value}
        yield(value)
      in {error: err}
        result
      end
    end
  end
end
