module NxtGqlConcerns
  module HasNamespaceInGqlName
    extend ActiveSupport::Concern

    class_methods do
      def default_graphql_name
        @default_graphql_name ||= begin
          parts = name.split("::").reverse.reject { |p| p.in?(%w[Ats Admin]) }
          parts = parts[0..-2] if parts.last.in?(%w[Types])
          parts = [parts[0], *parts[1..].map(&:singularize)]
          parts.join
        end
      end
    end
  end
end
