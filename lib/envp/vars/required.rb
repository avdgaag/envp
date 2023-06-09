# frozen_string_literal: true

require "delegate"
require_relative "base"
require_relative "../result"

module Envp
  module Vars
    # A `Var` that fails when the fetched value is not present.
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
