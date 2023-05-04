# frozen_string_literal: true

module EnvParser
  class Results
    def initialize(vars = {})
      @vars = vars
    end

    def []=(var, result)
      @vars[var] = result
    end

    def [](var)
      @vars[var]
    end

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
