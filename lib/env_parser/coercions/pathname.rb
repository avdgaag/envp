# frozen_string_literal: true

require "pathname"
require_relative "registry"

module EnvParser
  module Coercions
    Registry.default.register(Pathname) do |value|
      Pathname(value)
    end
  end
end
