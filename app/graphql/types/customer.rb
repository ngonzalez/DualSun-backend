module Types
  class Customer < BaseObject
    graphql_name "Customer"

    implements GraphQL::Types::Relay::Node
    global_id_field :id

    field :item_id, Integer
    field :name, String, null: false
    field :email, String, null: false
    field :phone, String, null: false

    def item_id
      self.object.id
    end
  end
end
