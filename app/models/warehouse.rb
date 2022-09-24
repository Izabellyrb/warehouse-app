class Warehouse < ApplicationRecord
    validates :name, :code, :city, :address, :area, :description, :zipcode, presence: true 
    validates :name, :code, uniqueness: true
    validates :zipcode, length: { is: 8 }
end
