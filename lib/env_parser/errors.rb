# frozen_string_literal: true

module EnvParser
  class Error < StandardError
  end

  class Failure < Error
  end

  class UnknownCoercion < Error
  end
end
