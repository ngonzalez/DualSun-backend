require "rails_helper"

RSpec.describe Customer, type: :model do
  context do 'order exists'
    setup do
      @order = FactoryBot.create(:order)
    end
    context do 'create a factory customer'
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
    context do 'a new customer'
      setup do
        @customer = @order.customers.new
      end
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_presence_of(:phone) }
    end
    context do 'a valid customer'
      setup do
        @customer = FactoryBot.create(:customer, order: @order)
      end
      it 'validates email' do
        expect(@customer.valid?).to eq(true)
      end
      context do 'it has no email'
        setup do
          @customer.email = nil
        end
        it 'is not valid' do
          expect(@customer.valid?).to eq(false)
          expect(@customer.errors.full_messages).to eq(["Email can't be blank", "Email is invalid"])
        end
      end
      context do 'it has an invalid email'
        setup do
          @customer.email = "test"
        end
        it 'is not valid' do
          expect(@customer.valid?).to eq(false)
          expect(@customer.errors.full_messages).to eq(["Email is invalid"])
        end
      end
      context do 'a valid email'
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
