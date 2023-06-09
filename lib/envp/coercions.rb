# frozen_string_literal: true

module Envp
  # Coercions allow you to transform string values read from the environment and
  # parse them into rich values. THere are various pre-defined coercions and you
  # can define you own.
  #
  # ## Pre-defined coercions
  #
  # * `Array`
  # * `BigDecimal`
  # * `Date`
  # * `DateTime`
  # * `Time`
  # * `Float`
  # * `Integer`
  # * `Pathname`
  # * `Regexp`
  # * `String`
  # * `URI`
  # * `:bool`
  # * `JSON`
  # * `Symbol`
  #
  # These coercions might require standard libraries. You can load exactly
  # those you require or load all of them at once:
  #
  #     require 'envp/coercions/array'
  #     require 'envp/coercions/all'
  #
  # ## Defining custom coercions
  #
  # See `Envp::Parser#accept`.
  module Coercions
  end
end
