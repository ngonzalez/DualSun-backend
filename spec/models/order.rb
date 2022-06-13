require "rails_helper"

RSpec.describe Order, type: :model do
  context do 'order and customers'
    setup do
      @order = FactoryBot.create(:order)
      @customer = FactoryBot.create(:customer, order: @order)
    end
    it 'has customers' do
      expect(@order.customers.length).to eq(1)
    end
  end
end
