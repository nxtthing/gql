module NxtGql
  module Analyzers
    class DuplicateLimit < GraphQL::Analysis::AST::Analyzer
      MAX_DUPLICATES = 20

      def initialize(query)
        super
        @fields = Set.new
        @duplicates = 0
      end

      def on_enter_field(_node, _parent, visitor)
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
