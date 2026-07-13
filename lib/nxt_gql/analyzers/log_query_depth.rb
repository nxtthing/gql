module Analyzers
  class LogQueryDepth < GraphQL::Analysis::QueryDepth
    def result
      depth = super

      Rails.logger.info(
        "[GraphQL Query Depth] " \
        "depth=#{depth} " \
        "operation=#{query.operation_name.inspect} "
      )

      depth
    end
  end
end
