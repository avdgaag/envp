# frozen_string_literal: true

require "bigdecimal"

module EnvParser
  module Coercions
    Registry.default.register(BigDecimal) do |value|
      BigDecimal(value)
    end
  end
end
