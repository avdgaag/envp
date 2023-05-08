# frozen_string_literal: true

require "bigdecimal"
require_relative "registry"

module Envp
  module Coercions
    Registry.default.register(BigDecimal) do |value|
      BigDecimal(value)
    end
  end
end
