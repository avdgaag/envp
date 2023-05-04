# frozen_string_literal: true

require "delegate"
require_relative "base"
require_relative "../result"

module EnvParser
  module Vars
    class Required < DelegateClass(Base)
      def from(env)
        Result.then(__getobj__.from(env)) do |value|
          if value
            Result.ok(value)
          else
            Result.error("missing required value")
          end
        end
      end
    end
  end
end
