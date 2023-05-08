# frozen_string_literal: true

require_relative "registry"

module Envp
  module Coercions
    Registry.default.register(:bool) do |value|
      case value
      when "1", "true" then true
      else false
      end
    end
  end
end
