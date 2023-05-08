# frozen_string_literal: true

require "delegate"
require_relative "base"
require_relative "../result"

module Envp
  module Vars
    # A `Var` that is read and than has a block applied to it, returning the
    # block return value.
    class Block < DelegateClass(Base)
      def initialize(var, &block)
        super(var)
        @block = block
      end

      def from(env)
        Result.map(__getobj__.from(env), &@block)
      end
    end
  end
end
