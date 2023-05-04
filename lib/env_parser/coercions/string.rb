# frozen_string_literal: true

module EnvParser
  module Coercions
    Registry.default.register(String) do |value|
      String(value)
    end
  end
end
