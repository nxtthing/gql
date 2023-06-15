Gem::Specification.new do |s|
  s.name        = "nxt_gql"
  s.summary     = "NxtGql"
  s.version     = "0.0.3"
  s.authors     = ["Aliaksandr Yakubenka"]
  s.email       = "alexandr.yakubenko@startdatelabs.com"
  s.files       = ["lib/nxt_gql.rb"]
  s.license       = "MIT"
  s.add_dependency "activesupport"
  s.add_dependency "graphql-ruby"
  s.add_dependency "action_policy-graphql"
  s.add_dependency "sentry-ruby"
end
