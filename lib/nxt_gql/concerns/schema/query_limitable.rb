module NxtGql
  module Concerns
    module Schema
      module QueryLimitable
        extend ActiveSupport::Concern

        included do
          max_depth 20
          # max_complexity 300
          # max_query_string_tokens 2500
          use GraphQL::Schema::Timeout, max_seconds: 100

          # complexity_cost_calculation_mode(:future)

          # query_analyzer(Analyzers::AliasLimit)
          # query_analyzer(Analyzers::DuplicateLimit)

          if Rails.env.development?
            query_analyzer(Analyzers::LogQueryDepth)
            query_analyzer(Analyzers::LogQueryComplexity)
          end
        end
      end
    end
  end
end
