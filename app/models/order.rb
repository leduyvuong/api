class Order < ApplicationRecord
  belongs_to :user
  before_create :default_status
  has_many :order_details, dependent: :destroy
  has_many :products, through: :order_details
  
  self.per_page = 8

  enum status: {pending: 0, shipping: 1, done: 2}

  validates :name, presence: :true
  validates :address, presence: :true
  
  VALID_PHONE = /(84|0[3|5|7|8|9])+([0-9]{8})\b/
  validates :phone, presence: :true, format: {with: VALID_PHONE}

  def default_status
    self.status ||= 0
  end

end
