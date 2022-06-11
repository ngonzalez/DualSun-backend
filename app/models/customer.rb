# == Schema Information
#
# Table name: customers
#
#  id         :bigint           not null, primary key
#  email      :string           not null
#  name       :string           not null
#  phone      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  order_id   :integer          not null
#
class Customer < ActiveRecord::Base
  belongs_to :order

  validates :name, presence: true

  validates :email, presence: true

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 

  validates :phone, presence: true

  has_paper_trail

  acts_as_paranoid
end
