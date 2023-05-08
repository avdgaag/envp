# frozen_string_literal: true

require "json"
require_relative "registry"

module Envp
  module Coercions
    Registry.default.register(JSON) do |value|
      JSON.parse(value)
    end
  end
end
