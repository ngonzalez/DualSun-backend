require "rails_helper"

RSpec.describe Mutations::CreateOrder do
  context "Mutations" do
    it "Create order" do
      variables = {
        companyName: Faker::Company.name,
        companySiren: Faker::Number.leading_zero_number(digits: 9),
        orderAddress: Faker::Address.full_address,
        orderDate: 10.days.from_now.to_s,
        customers: [{ name: Faker::Name.name, email: Faker::Internet.email, phone: Faker::PhoneNumber.cell_phone }].to_json,
        panels: [{ panelId: Faker::IDNumber.valid, panelType: PANEL_TYPES[:photovoltaic] },
                 { panelId: Faker::IDNumber.valid, panelType: PANEL_TYPES[:hybrid] }].to_json
      }

      query = GraphQL::Query.new(
        DualSunBackendSchema,
        mutation,
        variables: variables.deep_stringify_keys,
        context: {},
      )

      result = query.result

      expect(result.dig("data", "createOrder", "order", "companyName")).to eq(variables[:companyName])
      expect(result.dig("data", "createOrder", "order", "companySiren")).to eq(variables[:companySiren])
      expect(result.dig("data", "createOrder", "order", "orderAddress")).to eq(variables[:orderAddress])
      expect(result.dig("data", "createOrder", "order", "orderDate")).to eq(variables[:orderDate].to_s)
      expect(result.dig("data", "createOrder", "order", "panels")).to eq(variables[:panels])
      expect(result.dig("data", "createOrder", "customers", 0, "name")).to eq(JSON.parse(variables[:customers], symbolize_names: true)[0][:name])
      expect(result.dig("data", "createOrder", "customers", 0, "email")).to eq(JSON.parse(variables[:customers], symbolize_names: true)[0][:email])
      expect(result.dig("data", "createOrder", "customers", 0, "phone")).to eq(JSON.parse(variables[:customers], symbolize_names: true)[0][:phone])
    end
  end

  def mutation
    <<~GQL
    mutation createOrder(
      $companyName: String!,
      $companySiren: String!,
      $orderAddress: String!,
      $orderDate: String!,
      $customers: JSON!,
      $panels: JSON!
    ) {
      createOrder(input: {
        companyName: $companyName,
        companySiren: $companySiren,
        orderAddress: $orderAddress,
        orderDate: $orderDate,
        customers: $customers,
        panels: $panels,
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
