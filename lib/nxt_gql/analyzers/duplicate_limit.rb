module NxtGql
  module Analyzers
    class DuplicateLimit < GraphQL::Analysis::AST::Analyzer
      MAX_DUPLICATES = 25

      def initialize(query)
        super
        @nodes = Set.new
        @fields = Set.new
        @duplicates = 0
      end

      def on_enter_field(node, _parent, visitor)
        return unless @nodes.add?(node)

        field = [visitor.parent_type_definition, visitor.response_path]
        @duplicates += 1 unless @fields.add?(field)
      end

      def result
        return if @duplicates <= MAX_DUPLICATES

        GraphQL::AnalysisError.new("Query contains more than #{MAX_DUPLICATES} duplicate fields")
      end
    end
  end
end
