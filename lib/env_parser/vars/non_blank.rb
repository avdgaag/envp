# frozen_string_literal: true

require "delegate"
require_relative "base"
require_relative "../result"

module EnvParser
  module Vars
    class NonBlank < DelegateClass(Base)
      def from(env)
        Result.then(__getobj__.from(env)) do |value|
          if value.empty?
            Result.error("disallowed blank value")
          else
            Result.ok(value)
          end
        end
      end
    end
  end
end
