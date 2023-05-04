# frozen_string_literal: true

module EnvParser
  module Coercions
    Registry.default.register(Array) do |value|
      value.split(",")
    end
  end
end
