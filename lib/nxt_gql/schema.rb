require "nxt_gql/concerns/schema/errors_handleable"
require "nxt_gql/concerns/schema/query_limitable"

module NxtGql
  class Schema < GraphQL::Schema
    include Concerns::Schema::ErrorsHandleable
    include Concerns::Schema::QueryLimitable
  end
end
