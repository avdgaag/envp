# frozen_string_literal: true

module EnvParser
  module Coercions
    Registry.default.register(Float) do |value|
      Float(value)
    end
  end
end
