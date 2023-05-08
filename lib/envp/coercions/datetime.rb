# frozen_string_literal: true

require "time"
require_relative "registry"

module Envp
  module Coercions
    Registry.default.register(DateTime) do |value|
      DateTime.parse(value)
    end
  end
end
