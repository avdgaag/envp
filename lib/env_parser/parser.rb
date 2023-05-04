# frozen_string_literal: true

require_relative "coercions/registry"
require_relative "results"
require_relative "vars"
require_relative "errors"

module EnvParser
  class Parser
    def initialize(vars = Set.new, coercion_registry = Coercions::Registry.default)
      @vars = vars
      @coercion_registry = coercion_registry
    end

    def required(name, coercion = nil, allow_blank: true, &block)
      var = Vars::Base.new(name)
      var = Vars::Required.new(var)
      var = Vars::NonBlank.new(var) unless allow_blank
      var = Vars::Coerced.new(var, coercion, @coercion_registry) if coercion
      var = Vars::Block.new(var, block) if block
      @vars << var
    end

    def optional(name, coercion = nil, default: nil, &block)
      var = Vars::Base.new(name)
      var = Vars::DefaultValue.new(var, default)
      var = Vars::Coerced.new(var, coercion, @coercion_registry) if coercion
      var = Vars::Block.new(var, block) if block
      @vars << var
    end

    def parse(env)
      @vars.each_with_object(Results.new) do |spec, r|
        r[spec] = spec.from(env)
      rescue StandardError => e
        r[spec] = Result.error(e)
      end
    end

    def accept(target, &)
      @coercion_registry.register(target, &)
    end
  end
end
