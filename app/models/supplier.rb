class Supplier < ApplicationRecord
  has_many :product_models
  validates :corporate_name, :brand_name, :registration_number, :email, presence: true
  validates :registration_number, :email, :phone, uniqueness: true
  validates :registration_number, length: { is: 14 }
end