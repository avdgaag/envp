# frozen_string_literal: true

module EnvParser
  module Coercions
    Registry.default.register(Integer) do |value|
      Integer(value)
    end
  end
end
