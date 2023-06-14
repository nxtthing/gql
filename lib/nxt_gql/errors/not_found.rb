require "nxt_gql/errors/base"

module NxtGql
  module Errors
    class NotFound < Base
      CODE = 404
      DEFAULT_MESSAGE = "Not Found.".freeze

      def initialize(message = DEFAULT_MESSAGE)
        super(CODE, message)
      end
    end
  end
end
