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
class Customer < ActiveRecord::Base
  belongs_to :order

  validates :name, presence: true, allow_blank: false
  validates :email, presence: true, allow_blank: false
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone, presence: true, allow_blank: false

  has_paper_trail

  acts_as_paranoid
end
