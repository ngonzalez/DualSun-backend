require "rails_helper"

RSpec.describe "Creates an order" do
  subject(:request) {
    post "/graphql", headers: { 'Content-Type' => 'application/json' }, params: { query: query, variables: variables }.to_json
  }
  let(:query) do
    <<~GRAPHQL
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
    GRAPHQL
  end
  let(:variables) do
    {
      companyName: Faker::Company.name,
      companySiren: Faker::Number.leading_zero_number(digits: 9),
      orderAddress: Faker::Address.full_address,
      orderDate: 10.days.from_now,
      customers: "[{\"name\":\"#{Faker::Name.name}\",\"email\":\"#{Faker::Internet.email}\",\"phone\":\"#{Faker::PhoneNumber.cell_phone}\"}]",
      panels: "[{\"panelId\":\"#{Faker::IDNumber.valid}\",\"panelType\":\"#{PANEL_TYPES[:photovoltaic]}\"},
                {\"panelId\":\"#{Faker::IDNumber.valid}\",\"panelType\":\"#{PANEL_TYPES[:hybrid]}\"}]"
    }
  end
  let(:expected_result) do
    {
      data: {
        createOrder: {
          order: {
            companyName: variables[:companyName],
            companySiren: variables[:companySiren],
            orderAddress: variables[:orderAddress],
            orderDate: variables[:orderDate].to_s,
            panels: variables[:panels],
          },
          customers: [
            {
              name: JSON.parse(variables[:customers], symbolize_names: true)[0][:name],
              email: JSON.parse(variables[:customers], symbolize_names: true)[0][:email],
              phone: JSON.parse(variables[:customers], symbolize_names: true)[0][:phone],
            }
          ],
          success: true,
          errors: [],
        },
      }
    }
  end

  it "returns a 200 HTTP code" do
    request
    expect(response).to have_http_status :ok
  end

  it "returns company details" do
    request
    expect(JSON.parse(response.body).deep_symbolize_keys).to include_json expected_result
  end
end
