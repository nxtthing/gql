module NxtGql
  module Concerns
    module Schema
      module QueryLimitable
        extend ActiveSupport::Concern

        included do
          max_depth 20
          max_complexity 300
          use GraphQL::Schema::Timeout, max_seconds: 100

          complexity_cost_calculation_mode(:future)

          if Rails.env.development?
            query_analyzer(Analyzers::LogQueryDepth)
            query_analyzer(Analyzers::LogQueryComplexity)
          end
        end
      end
    end
  end
end
