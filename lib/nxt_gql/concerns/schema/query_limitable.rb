module NxtGql
  module Concerns
    module Schema
      module QueryLimitable
        extend ActiveSupport::Concern

        included do
          max_depth 20
          use GraphQL::Schema::Timeout, max_seconds: 100
        end
      end
    end
  end
end
