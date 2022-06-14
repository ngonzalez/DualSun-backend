# == Schema Information
#
# Table name: customers
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  email      :string           not null
#  name       :string           not null
#  phone      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  order_id   :integer          not null
#
# Indexes
#
#  index_customers_on_order_id  (order_id) UNIQUE
#
require "rails_helper"

RSpec.describe Customer, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:phone) }
  context 'order exists' do
    setup do
      @order = FactoryBot.create(:order)
    end
    context 'create a factory customer' do
      setup do
        @customer = FactoryBot.create(:customer, order: @order)
      end
      it 'order has customers' do
        expect(@order.customers.length).to eq(1)
      end
      it 'customer is attached to order' do
        expect(@customer.order).to eq(@order)
      end
    end
    context 'a new customer' do
      setup do
        @customer = @order.customers.new
      end
    end
    context 'a valid customer' do
      setup do
        @customer = FactoryBot.create(:customer, order: @order)
      end
      it 'validates email' do
        expect(@customer.valid?).to eq(true)
      end
      context 'it has no email' do
        setup do
          @customer.email = nil
        end
        it 'is not valid' do
          expect(@customer.valid?).to eq(false)
          expect(@customer.errors.full_messages).to eq(["Email can't be blank", "Email is invalid"])
        end
      end
      context 'it has an invalid email' do
        setup do
          @customer.email = "test"
        end
        it 'is not valid' do
          expect(@customer.valid?).to eq(false)
          expect(@customer.errors.full_messages).to eq(["Email is invalid"])
        end
      end
      context 'a valid email' do
        setup do
          @customer.email = "test@example.com"
        end
        it 'is not valid' do
          expect(@customer.valid?).to eq(true)
          expect(@customer.errors.full_messages).to eq([])
        end
      end
    end
  end
end
