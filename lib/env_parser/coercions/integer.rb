# frozen_string_literal: true

require_relative "registry"

module EnvParser
  module Coercions
    Registry.default.register(Integer) do |value|
      Integer(value)
    end
  end
end
