# frozen_string_literal: true

require "delegate"
require_relative "base"
require_relative "../result"

module EnvParser
  module Vars
    class Coerced < DelegateClass(Base)
      def initialize(name, target, coercions)
        super(name)
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
