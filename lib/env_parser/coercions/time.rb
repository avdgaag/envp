# frozen_string_literal: true

require "time"
require_relative "registry"

module EnvParser
  module Coercions
    Registry.default.register(Time) do |value|
      Time.parse(value)
    end
  end
end
