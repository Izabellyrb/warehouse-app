require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do 
    it 'deve ter código' do
      #Arrange
      user = User.create!(name: 'Maria silva', email: 'maria@gmail.com', password: 'password')
      warehouse = Warehouse.create!(name: 'Galpãozão', code: 'COD', city: 'Cidade', address: 'Endereço, 2', 
      area: 10_000, description: 'Alguma descrição.', zipcode: '12346578')
      supplier = Supplier.create!(corporate_name: 'ACME Marcas ltda', brand_name:'ACME ltda', registration_number:'75443709000160', 
      address:'Rua Pamplona, 1083', city:'São Paulo', state:'SP', email:'contato@acme.com', phone: '1124384557')

      order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2022-10-01')

      #Act
      result = order.valid?

      #Assert
      expect(result).to eq true
    end

    it 'data estimada de entrega deve ser obrigatória' do
      #Arrange
      order = Order.new(estimated_delivery_date: '') #teste específico neste campo

      #Act
      order.valid?
      result = expect(order.errors.include? :estimated_delivery_date).to eq true

      #Assert
      expect(result).to eq true
    end

    it 'data estimada de entrega não deve ser passado' do
      #Arrange
      order = Order.new(estimated_delivery_date: 1.day.ago) #teste específico neste campo

      #Act
      order.valid?

      #Assert
      expect(order.errors.include?(:estimated_delivery_date)).to eq true
      expect(order.errors[:estimated_delivery_date]).to include("deve ser futura")
    end

    it 'data estimada de entrega não deve ser igual a hoje' do
      #Arrange
      order = Order.new(estimated_delivery_date: Date.today) #teste específico neste campo

      #Act
      order.valid?

      #Assert
      expect(order.errors.include?(:estimated_delivery_date)).to eq true
      expect(order.errors[:estimated_delivery_date]).to include("deve ser futura")
    end

    it 'data estimada de entrega deve ser igual ou maior que amanhã' do
      #Arrange
      order = Order.new(estimated_delivery_date: 1.day.from_now) #teste específico neste campo

      #Act
      order.valid?

      #Assert
      expect(order.errors.include?(:estimated_delivery_date)).to eq false
    end
  end

  describe 'gerador código aleatório' do 
    it 'ao criar novo pedido' do
      #Arrange
      # necessário ser create pois dados serão "salvos" e reurilizados para validação.
      user = User.create!(name: 'Maria silva', email: 'maria@gmail.com', password: 'password')
      warehouse = Warehouse.create!(name: 'Galpãozão', code: 'COD', city: 'Cidade', address: 'Endereço, 2', 
      area: 10_000, description: 'Alguma descrição.', zipcode: '12346578')
      supplier = Supplier.create!(corporate_name: 'ACME Marcas ltda', brand_name:'ACME ltda', registration_number:'75443709000160', 
      address:'Rua Pamplona, 1083', city:'São Paulo', state:'SP', email:'contato@acme.com', phone: '1124384557')

      order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2022-10-01')

      #Act
      order.save!
      result = order.code

      #Assert
      expect(result).not_to be_empty
      expect(result.length).to eq 10
    end

    it 'e o código é único' do
      #Arrange
      
      user = User.create!(name: 'Maria silva', email: 'maria@gmail.com', password: 'password')
      warehouse = Warehouse.create!(name: 'Galpãozão', code: 'COD', city: 'Cidade', address: 'Endereço, 2', 
      area: 10_000, description: 'Alguma descrição.', zipcode: '12346578')
      supplier = Supplier.create!(corporate_name: 'ACME Marcas ltda', brand_name:'ACME ltda', registration_number:'75443709000160', 
      address:'Rua Pamplona, 1083', city:'São Paulo', state:'SP', email:'contato@acme.com', phone: '1124384557')

      first_order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2022-10-01')

      second_order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2022-12-15')

      #Act
      second_order.save!

      #Assert
      expect(second_order.code).not_to eq(first_order.code)
    end
  end
end
