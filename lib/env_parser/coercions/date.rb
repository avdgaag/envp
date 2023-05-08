# frozen_string_literal: true

require "time"
require_relative "registry"

module EnvParser
  module Coercions
    Registry.default.register(Date) do |value|
      Date.parse(value)
    end
  end
end
