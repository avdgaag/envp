# frozen_string_literal: true

require "time"

module EnvParser
  module Coercions
    Registry.default.register(DateTime) do |value|
      DateTime.parse(value)
    end
  end
end
