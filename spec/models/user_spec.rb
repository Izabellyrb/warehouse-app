require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid?' do
    it 'false when name is empty' do
      #Arrange
      user = User.new(name: '', email: 'maria@gmail.com', password: 'password')

      #Act
      result = user.valid?

      #Assert
      expect(result).to eq false
    end
  end

  describe '#description' do
    it 'mostra nome e email' do
    #Arrange
    supplier = Supplier.new(brand_name: 'ACME ltda', corporate_name: 'ACME Industria Ltda.' , registration_number: '75443709000160')

    #Act
    result = supplier.full_supplier

    #Assert
    expect(result).to eq('ACME ltda | ACME Industria Ltda. | 75443709000160')
    end
  end
end
