 class ProductModel < ApplicationRecord
  belongs_to :supplier
  validates :name, :sku, :weight, :width, :height, :depth, :supplier, presence: true
  validates :sku, uniqueness: true
  validates :weight, :width, :height, :depth, numericality: { greater_than: 0 }
  validates :sku, length: { maximum: 20 }
end
