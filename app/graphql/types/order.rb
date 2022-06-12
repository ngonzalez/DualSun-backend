module Types
  class Order < BaseObject
    graphql_name "Order"

    implements GraphQL::Types::Relay::Node
    global_id_field :id

    field :item_id, Integer, null: false
    field :company_name, String, null: false
    field :company_siren, String, null: false
    field :order_address, String, null: false
    field :order_date, String, null: false
    field :customers, GraphQL::Types::JSON, null: false
    field :panels, GraphQL::Types::JSON, null: false

    def item_id
      self.object.id
    end
  end
end
