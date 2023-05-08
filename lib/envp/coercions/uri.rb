# frozen_string_literal: true

require "uri"
require_relative "registry"

module Envp
  module Coercions
    Registry.default.register(URI) do |value|
      URI.parse(value)
    end
  end
end
