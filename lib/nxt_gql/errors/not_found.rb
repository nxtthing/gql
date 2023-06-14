require "nxt_gql/errors/base_error"

module NxtGql
  module Errors
    class NotFound < BaseError
      CODE = 404
      DEFAULT_MESSAGE = "Not Found.".freeze

      def initialize(message = DEFAULT_MESSAGE)
        super(CODE, message)
      end
    end
  end
end
