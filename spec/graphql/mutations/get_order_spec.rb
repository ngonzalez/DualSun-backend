require "rails_helper"

RSpec.describe Mutations::GetOrder do
  context "Mutations" do

    before(:each) do
      @order = FactoryBot.create(:order)
      @customer = FactoryBot.create(:customer, order: @order)
    end

    it "Get order" do
      variables = {
        orderId: @order.id,
      }

      query = GraphQL::Query.new(
        DualSunBackendSchema,
        mutation,
        variables: variables,
        context: {},
      )

      result = query.result

      expect(result.dig("data", "getOrder", "order", "companyName")).to eq(@order.company_name)
      expect(result.dig("data", "getOrder", "order", "companySiren")).to eq(@order.company_siren)
      expect(result.dig("data", "getOrder", "order", "orderAddress")).to eq(@order.order_address)
      expect(result.dig("data", "getOrder", "order", "orderDate")).to eq(@order.order_date.to_s)
      expect(result.dig("data", "getOrder", "customers", 0, "name")).to eq(@customer.name)
      expect(result.dig("data", "getOrder", "customers", 0, "email")).to eq(@customer.email)
      expect(result.dig("data", "getOrder", "customers", 0, "phone")).to eq(@customer.phone)
    end
  end

  def mutation
    <<~GQL
    mutation getOrder(
      $orderId: Int!,
    ) {
      getOrder(input: {
        orderId: $orderId,
      }) {
        order {
          itemId
          companyName
          companySiren
          orderAddress
          orderDate
          panels
        }
        customers {
          itemId
          name
          email
          phone
        }
        success
        errors
      }
    }
    GQL
  end
end
