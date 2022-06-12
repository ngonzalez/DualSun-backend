module Mutations
  class GetOrder < Mutations::BaseMutation
    graphql_name "GetOrder"

    argument :order_id, Int, required: true

    field :order, Types::Order, null: false
    field :customers, [Types::Customer], null: false

    def resolve(args)
      order = Order.find args[:order_id]

      MutationResult.call(
        obj: {
          order: order,
          customers: order.customers,
        },
        success: order.persisted?,
        errors: [],
      )
    end
  end
end
