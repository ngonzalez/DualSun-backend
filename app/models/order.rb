# == Schema Information
#
# Table name: orders
#
#  id            :bigint           not null, primary key
#  company_name  :string           not null
#  company_siren :string           not null
#  deleted_at    :datetime
#  order_address :string           not null
#  order_date    :datetime         not null
#  panels        :jsonb            not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Order < ActiveRecord::Base
  has_many :customers
  
  validates :company_name, presence: true

  validates :company_siren, presence: true
  validates :company_siren, length: { is: 9 }

  validates :order_address, presence: true

  validates :order_date, presence: true
  validates :order_date, comparison: { greater_than: Date.today }

  has_paper_trail

  acts_as_paranoid
end
