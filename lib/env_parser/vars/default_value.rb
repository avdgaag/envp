# frozen_string_literal: true

require "delegate"
require_relative "base"
require_relative "../result"

module EnvParser
  module Vars
    class DefaultValue < DelegateClass(Base)
      def initialize(var, default)
        super(var)
        @default = default
      end

      def from(env)
        Result.map(__getobj__.from(env)) do |value|
          value || @default
        end
      end
    end
  end
end
