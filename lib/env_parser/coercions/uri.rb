# frozen_string_literal: true

require "uri"

module EnvParser
  module Coercions
    Registry.default.register(URI) do |value|
      URI.parse(value)
    end
  end
end
