module Mutations
  class CreateOrder < Mutations::BaseMutation
    graphql_name "CreateOrder"

    argument :company_name, String, required: true
    argument :company_siren, String, required: true
    argument :order_address, String, required: true
    argument :order_date, String, required: true
    argument :customers, GraphQL::Types::JSON, required: true
    argument :panels, GraphQL::Types::JSON, required: true

    field :order, Types::Order, null: false
    field :customers, [Types::Customer], null: false

    def resolve(args)
      errors = []
      begin
        order = Order.create(
          company_name: args[:company_name],
          company_siren: args[:company_siren],
          order_address: args[:order_address],
          order_date: args[:order_date],
          panels: args[:panels],
        )
        if !order.persisted?
          errors << order.errors.full_messages
        end
      rescue ActiveRecord::RecordInvalid => exception
        Rails.logger.debug exception
      end

      customers_json = JSON.parse args[:customers], symbolize_names: true
      if order.persisted?
        customers_json.each do |customer_json|
          begin
            customer = order.customers.create(
              name: customer_json[:name],
              email: customer_json[:email],
              phone: customer_json[:phone]
            )
            if !customer.persisted?
              errors << order.errors.full_messages
            end
          rescue ActiveRecord::RecordInvalid => exception
            Rails.logger.debug exception
            errors << customer.errors.full_messages
          end
        end
      end

      MutationResult.call(
        obj: {
          order: order,
          customers: order.customers,
        },
        success: order.persisted? && errors.empty?,
        errors: errors,
      )
    end
  end
end
