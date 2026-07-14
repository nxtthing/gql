module NxtGql
  module Analyzers
    class LogQueryComplexity < GraphQL::Analysis::QueryComplexity
      def result
        complexity = super

        Rails.logger.info(
          "[GraphQL Query Complexity] " \
          "complexity=#{complexity} " \
          "operation=#{query.operation_name.inspect} "
        )

        complexity
      end
    end
  end
end