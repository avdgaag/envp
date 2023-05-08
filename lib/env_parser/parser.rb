# frozen_string_literal: true

require_relative "coercions/registry"
require_relative "results"
require_relative "vars"
require_relative "errors"

module EnvParser
  # The `Parser` defines environment variable requirements along with custom
  # available coercions, and then uses those requirements to read environment
  # variables into a single result value.
  class Parser
    # @param vars [Set] initial set of vars.
    # @param coercion_registry [ParserEnv::Coercions::Registry]
    def initialize(vars = Set.new, coercion_registry = Coercions::Registry.default)
      @vars = vars
      @coercion_registry = coercion_registry
    end

    # Require an enviroment variable.
    #
    # @param name [String] the name of the environment variable to fetch.
    # @param coercion [Object] what to coerce the fetched value to.
    # @param allow_blank [Boolean] whether to fail when the value is empty (defaults to `true`)
    # @yield value [Object] the coerced value fetched from the environment
    # @return [void]
    def required(name, coercion = nil, allow_blank: true, &block)
      var = Vars::Base.new(name)
      var = Vars::Required.new(var)
      var = Vars::NonBlank.new(var) unless allow_blank
      var = Vars::Coerced.new(var, coercion, @coercion_registry) if coercion
      var = Vars::Block.new(var, &block) if block
      @vars << var
    end

    # Get an enviroment variable, if it exists.
    #
    # @param name [String] the name of the environment variable to fetch.
    # @param coercion [Object] what to coerce the fetched value to.
    # @param default [Object] value to use when the value is not set (defaults to `nil`)
    # @yield value [Object] the coerced value fetched from the environment
    # @return [void]
    def optional(name, coercion = nil, default: nil, &block)
      var = Vars::Base.new(name)
      var = Vars::DefaultValue.new(var, default)
      var = Vars::Coerced.new(var, coercion, @coercion_registry) if coercion
      var = Vars::Block.new(var, &block) if block
      @vars << var
    end

    # Actually parse the specified variables from the given hash-like value
    # (probably `ENV`).
    #
    # @param env [#to_h]
    # @return [EnvParser::Results]
    def parse(env)
      @vars.each_with_object(Results.new) do |spec, r|
        r[spec] = spec.from(env)
      rescue StandardError => e
        r[spec] = Result.error(e)
      end
    end

    # Define a custom coercion target. This can then be used in variable
    # requirements as a coercion strategy.
    #
    # @example
    #   parser = Parser.new
    #   parser.accept(User) { |id| User.find(id) }
    #   parser.require("USER", User)
    #   parser.parse({ "USER" => "1" }) => { ok: { "USER" => user }}
    #   user # => #<User ...>
    #
    # @param target [Object]
    # @yield value [String]
    # @return [void]
    def accept(target, &)
      @coercion_registry.register(target, &)
    end
  end
end
