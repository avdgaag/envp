# frozen_string_literal: true

module Envp
  class Error < StandardError
  end

  class Failure < Error
  end

  class UnknownCoercion < Error
  end
end
