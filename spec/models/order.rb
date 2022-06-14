require "rails_helper"

RSpec.describe Order, type: :model do
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
  context do 'a new order'
    setup do
       @order = FactoryBot.build(:order, panels: nil)
    end
    it { is_expected.to validate_presence_of(:company_name) }
    it { is_expected.to validate_presence_of(:company_siren) }
    it { is_expected.to validate_presence_of(:order_address) }
    it { is_expected.to validate_presence_of(:order_date) }
    it 'has no panels' do
      expect(@order.panels).to be_nil
    end
    it 'a valid panel' do
      panel = [{ "panelId" => Faker::IDNumber.valid, "panelType" => PANEL_TYPES[:photovoltaic] }]
      @order.panels = panel.to_json
      expect(JSON.parse(@order.panels)).to eq(panel)
      expect(@order.save).to eq(true)
      expect(@order.errors.full_messages).to eq([])
    end
    it 'an invalid panel because of panelType' do
      panel = [{ "panelId" => Faker::IDNumber.valid, "panelType" => "test" }]
      @order.panels = panel.to_json
      expect(JSON.parse(@order.panels)).to eq(panel)
      expect(@order.save).to eq(false)
      expect(@order.errors.full_messages).to eq([I18n.t('errors.invalid_panels')])
    end
  end
end
