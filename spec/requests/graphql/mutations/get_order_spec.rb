require "rails_helper"

RSpec.describe "Get an order" do
  require "rails_helper"

  before(:each) do
    @order = FactoryBot.create(:order)
    @customer = FactoryBot.create(:customer, order: @order)
  end

  subject(:request) {
    post "/graphql", headers: { 'Content-Type' => 'application/json' }, params: { query: query, variables: variables }.to_json
  }

  let(:query) do
    <<~GRAPHQL
    mutation getOrder(
      $orderId: Int!
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
    GRAPHQL
  end
  let(:variables) do
    {
      orderId: @order.id,
    }
  end
  let(:expected_result) do
    {
      data: {
        getOrder: {
          order: {
            companyName: @order.company_name,
            companySiren: @order.company_siren,
            orderAddress: @order.order_address,
            orderDate: @order.order_date.to_s,
            panels: @order.panels,
          },
          customers: [
            {
              name: @customer.name,
              email: @customer.email,
              phone: @customer.phone,
            },
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
