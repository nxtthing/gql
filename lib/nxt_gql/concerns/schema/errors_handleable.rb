module NxtGql
  module Concerns
    module Schema
      module ErrorsHandleable
        extend ActiveSupport::Concern

        included do
          rescue_from(NxtGql::Errors::Base) do |exp, _obj, _args, ctx, _field|
            raise exp if ctx[:async]

            raise GraphQL::ExecutionError.new(exp.message, extensions: { code: exp.code, **exp.extra })
          end

          rescue_from(ActionPolicy::AuthorizationContextMissing) do |exp, _obj, _args, ctx, _field|
            raise exp if ctx[:async]

            raise GraphQL::ExecutionError.new("You are not unauthorized for this action.", extensions: { code: 401 })
          end

          rescue_from(ActionPolicy::Unauthorized) do |exp, _obj, _args, ctx, _field|
            raise exp if ctx[:async]

            raise GraphQL::ExecutionError.new(
              "You are not unauthorized for this action.",
              extensions: { code: 403, fullMessages: exp.result.reasons.full_messages, details: exp.result.reasons.details }
            )
          end

          rescue_from(::StandardError) do |exp, _obj, _args, ctx, _field|
            notify_sentry(exp, ctx)

            raise exp if ctx[:async]

            Rails.logger.error(([exp] + exp.backtrace).join("\n"))

            raise GraphQL::ExecutionError.new("Internal Server Error", extensions: { code: 500 })
          end
        end

        class_methods do
          def notify_sentry(exp, ctx)
            ::Sentry.capture_exception(
              exp,
              contexts: {
                "grapql-ruby" => {
                  query: ctx.query.query_string,
                  variables: ctx.query.variables.to_h,
                  context: ctx.to_h
                }
              }
            )
          end

          # GraphQL-Ruby calls this when something goes wrong while running a query:
          def type_error(exp, ctx)
            notify_sentry(exp, ctx)
            super
          end
        end
      end
    end
  end
end
