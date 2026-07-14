module NxtGql
  module Analyzers
    class AliasLimit < GraphQL::Analysis::AST::Analyzer
      MAX_ALIASES = 15

      def initialize(query)
        super
        @aliases = Set.new
      end

      def on_enter_field(node, _parent, _visitor)
        @aliases << node if node.alias
      end

      def result
        return if @aliases.size <= MAX_ALIASES

        GraphQL::AnalysisError.new("Query contains more than #{MAX_ALIASES} aliases")
      end
    end
  end
end
