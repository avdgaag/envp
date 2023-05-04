# frozen_string_literal: true

require_relative "env_parser/version"
require_relative "env_parser/parser"

module EnvParser
  def self.parse(env: ENV)
    case yield(Parser.new).parse(env)
    in { ok: results }
      results
    in { error: errors }
      msg = errors.map do |key, value|
        "#{key}: #{value}"
      end
      raise Failure, msg.join("\n")
    end
  end
end
