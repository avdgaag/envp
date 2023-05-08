# frozen_string_literal: true

require_relative "registry"

module Envp
  module Coercions
    Registry.default.register(Float) do |value|
      Float(value)
    end
  end
end
