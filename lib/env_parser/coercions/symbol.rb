# frozen_string_literal: true

require_relative "registry"

module EnvParser
  module Coercions
    Registry.default.register(Symbol) do |value|
      String(value).to_sym
    end
  end
end
