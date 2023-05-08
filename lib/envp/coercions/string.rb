# frozen_string_literal: true

require_relative "registry"

module Envp
  module Coercions
    Registry.default.register(String) do |value|
      String(value)
    end
  end
end
