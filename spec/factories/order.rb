FactoryBot.define do
  factory :order do
    company_name { Faker::Company.name }
    company_siren { Faker::Number.leading_zero_number(digits: 9) }
    order_address { Faker::Address.full_address }
    order_date { 10.days.from_now }
    panels { "[{\"panelId\":\"#{Faker::IDNumber.valid}\",\"panelType\":\"#{PANEL_TYPES[:photovoltaic]}\"}]" }
  end
end
