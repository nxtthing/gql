module NxtGql
  module Errors
    class BaseError < ::StandardError
      attr_reader :code, :extra

      def initialize(code, message, extra = {})
        @code = code
        @extra = extra
        super(message)
      end
    end
  end
end