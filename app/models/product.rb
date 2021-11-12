class Product < ApplicationRecord
  belongs_to :category
  has_many_attached :images
  before_create :default_status
  has_many :order_details
  has_many :orders, through: :order_details
  
  validates :product_name, presence: :true
  validates :price, presence: :true
  validates :description, presence: :true


  self.per_page = 8
  scope :active, -> { where(status: 1)}

  scope :sort_name_asc, -> { order(product_name: :asc).where(status: 1)}
  scope :sort_name_desc, -> { order(product_name: :desc).where(status: 1)}
  scope :sort_price_desc, -> { order(price: :desc).where(status: 1)}
  scope :sort_price_asc, -> { order(price: :asc)..where(status: 1)}
  scope :drink, -> { where(category_id: 2)}
  scope :food, -> { where(category_id: 1)}


  include Rails.application.routes.url_helpers
  def getUrl image
    rails_blob_path(image, only_path: true) if self.images.attached?
  end

  def default_status
    self.status ||= 1
  end

  def self.filter name
    case name
    when "sort_name_asc"
      sort_name_asc
    when "sort_name_desc"
      sort_name_desc
    when "sort_price_desc"
      sort_price_desc
    when "sort_price_asc"
      sort_price_asc
    when "drink"
      drink
    when "food"
      food
    else
      active
    end
  end
end
