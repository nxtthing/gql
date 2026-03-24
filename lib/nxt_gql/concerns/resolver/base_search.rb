module NxtGql
  module Concerns
    module Resolver
      module BaseSearch
        def resolve(filter: nil, pagination: nil, sort: nil)
          query = base_query
          query = filter.resolve(query) if filter
          if pagination
            pagination.resolve(query) do |q|
              sort_query(sort:, query: q)
            end
          else
            total = query.count
            nodes = sort_query(sort:, query:)
            { nodes:, total: }
          end
        end

        protected

        def sort_query(sort:, query:)
          sort ? sort.resolve(query) : query
        end

        def base_query
          raise NotImplementedError, "#base_query"
        end
      end
    end
  end
end
