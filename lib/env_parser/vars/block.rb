# frozen_string_literal: true

require "delegate"
require_relative "base"
require_relative "../result"

module EnvParser
  module Vars
    class Block < DelegateClass(Base)
      def initialize(name, block)
        super(name)
        @block = block
      end

      def from(env)
        Result.map(__getobj__.from(env), &@block)
      end
    end
  end
end
