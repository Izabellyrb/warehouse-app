 class ProductModel < ApplicationRecord
  belongs_to :supplier
  has_many :order_items
  has_many :orders, through: :order_items
  
  validates :name, :sku, :weight, :width, :height, :depth, :supplier, presence: true
  validates :sku, uniqueness: true
  validates :weight, :width, :height, :depth, numericality: { greater_than: 0 }
  validates :sku, length: { maximum: 20 }
end
