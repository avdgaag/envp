# frozen_string_literal: true

require_relative "registry"

module EnvParser
  module Coercions
    Registry.default.register(Array) do |value|
      String(value).split(",").map(&:strip)
    end
  end
end
