require "nxt_gql/errors/base"

module NxtGql
  module Errors
    class ValidationFailed < Base
      CODE = 422
      DEFAULT_MESSAGE = "Failed to execute. Please enter valid values and try again.".freeze

      def initialize(message = DEFAULT_MESSAGE, form_errors: {})
        super(CODE, message, { formErrors: form_errors })
      end
    end
  end
end