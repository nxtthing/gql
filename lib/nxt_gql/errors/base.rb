module NxtGql
  module Errors
    class Base < ::StandardError
      attr_reader :code, :extra

      def initialize(code, message, extra = {})
        @code = code
        @extra = extra
        super(message)
      end
    end
  end
end