# frozen_string_literal: true

require_relative "../result"

module EnvParser
  module Vars
    class Base
      attr_reader :name

      def initialize(name)
        @name = name
      end

      def from(env)
        Result.ok(env.to_h[@name])
      end
    end
  end
end
