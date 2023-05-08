# frozen_string_literal: true

require_relative "registry"

module Envp
  module Coercions
    Registry.default.register(Regexp) do |value|
      Regexp.new(value)
    end
  end
end
