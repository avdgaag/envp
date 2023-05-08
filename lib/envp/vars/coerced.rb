# frozen_string_literal: true

require "delegate"
require_relative "base"
require_relative "../result"

module Envp
  module Vars
    # A `Var` that is coerced using available transformations in the given
    # coercions registry.
    class Coerced < DelegateClass(Base)
      # @param name [Base]
      # @param target [Object]
      # @param coercions [Envp::Coercions::Registry]
      def initialize(var, target, coercions)
        super(var)
        @target = target
        @coercions = coercions
      end

      def from(env)
        Result.then(__getobj__.from(env)) do |value|
          if @coercions.coerces?(@target)
            Result.ok(@coercions.coerce(@target, value))
          else
            Result.error("unknown coercion #{@target.inspect}")
          end
        rescue StandardError => e
          Result.error(e.message)
        end
      end
    end
  end
end
