require "rails_helper"

RSpec.describe Customer, type: :model do
  context do 'order and customer'
    setup do
      @order = FactoryBot.create(:order)
      @customer = FactoryBot.create(:customer, order: @order)
    end
    it 'has customers' do
      expect(@order.customers.length).to eq(1)
    end
    it 'is attached to order' do
      expect(@customer.order).to eq(@order)
    end
  end
  context do 'a new customer'
    setup do
      @order = FactoryBot.create(:order)
      @customer = @order.customers.new
    end
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:phone) }
  end
end
