require "rails_helper"

RSpec.describe Order, type: :model do
  it { is_expected.to validate_presence_of(:company_name) }
  it { is_expected.to validate_presence_of(:company_siren) }
  it { is_expected.to validate_presence_of(:order_address) }
  it { is_expected.to validate_presence_of(:order_date) }
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
  context do 'a new order with empty company siren'
    setup do
       @order = FactoryBot.build(:order, company_siren: nil)
    end
    it 'has no company siren' do
      expect(@order.company_siren).to be_nil
    end
    context do 'a valid company siren'
      setup do
        @order.company_siren = '123456789'
      end
      it 'should be valid' do
        expect(@order.save).to eq(true)
        expect(@order.errors.full_messages).to eq([])
      end
      context do 'an invalid company siren'
        setup do
          @order.company_siren = '12345678'
        end
        it 'should not be valid' do
          expect(@order.save).to eq(false)
          expect(@order.errors.full_messages).to eq(["Company siren is the wrong length (should be 9 characters)"])
        end
      end
    end
  end
  context do 'a new order with empty order date'
    setup do
       @order = FactoryBot.build(:order, order_date: nil)
    end
    it 'has no order date' do
      expect(@order.order_date).to be_nil
    end
    context do 'a valid order date'
      setup do
        @order.order_date = Date.tomorrow
      end
      it 'should be valid' do
        expect(@order.save).to eq(true)
        expect(@order.errors.full_messages).to eq([])
      end
      context do 'an invalid order date before today'
        setup do
          @order.order_date = Date.yesterday
        end
        it 'should not be valid' do
          expect(@order.save).to eq(false)
          expect(@order.errors.full_messages).to eq(["Order date must be greater than #{Date.today}"])
        end
      end
    end
  end
  context do 'a new order with empty panels'
    setup do
       @order = FactoryBot.build(:order, panels: nil)
    end
    it 'has no panels' do
      expect(@order.panels).to be_nil
    end
    context do 'valid panels'
      setup do
        @panel = [{ "panelId" => Faker::IDNumber.valid, "panelType" => PANEL_TYPES[:photovoltaic] }]
        @order.panels = @panel.to_json
      end
      it 'should return panel' do
        expect(JSON.parse(@order.panels)).to eq(@panel)
      end
      it 'should be valid' do
        expect(@order.save).to eq(true)
        expect(@order.errors.full_messages).to eq([])
      end
    end
    context do 'invalid panels'
      setup do
        @panel = [{ "panelId" => Faker::IDNumber.valid, "panelType" => "test" }]
        @order.panels = @panel.to_json
      end
      it 'should return panel' do
        expect(JSON.parse(@order.panels)).to eq(@panel)
      end
      it 'should not be valid because of panelType' do
        expect(@order.save).to eq(false)
        expect(@order.errors.full_messages).to eq([I18n.t('errors.invalid_panels')])
      end
    end
  end
end
