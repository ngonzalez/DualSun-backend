module Types
  class MutationType < Types::BaseObject
    field :create_order, mutation: Mutations::CreateOrder
    field :get_order, mutation: Mutations::GetOrder
  end
end
