class UserProfile < ApplicationRecord
  belongs_to :user
  validates :name, presence: :true, length: {minimum:10}
  validates :date_of_birth, presence: :true
  validates :address, presence: :true, length: {minimum:20}
  validates :phone, presence: :true, length: {minimum:10}
end
