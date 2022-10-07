require 'rails_helper'

RSpec.describe StockProduct, type: :model do
  describe 'gerador numero de serie aleatório' do 
    it 'ao criar um produto no estoque' do
      #Arrange
      user = User.create!(name: 'Maria silva', email: 'maria@gmail.com', password: 'password')
      warehouse = Warehouse.create!(name: 'Galpãozão', code: 'COD', city: 'Cidade', address: 'Endereço, 2', 
      area: 10_000, description: 'Alguma descrição.', zipcode: '12346578')
      supplier = Supplier.create!(corporate_name: 'ACME Marcas ltda', brand_name:'ACME ltda', registration_number:'75443709000160', 
      address:'Rua Pamplona, 1083', city:'São Paulo', state:'SP', email:'contato@acme.com', phone: '1124384557')

      order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now.to_date, status: 'delivered')

      product = ProductModel.create!(name:'Produto A', weight: 1, width: 15, height: 20, depth: 30, 
      sku:'PROD0A-SAMS-AWEF5', supplier: supplier)  
      
      #Act
      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product)
      
      #Assert
      expect(stock_product.serial_number.length).to eq 20
    end
    it 'e não deve ser modificado' do
      #Arrange
      user = User.create!(name: 'Maria silva', email: 'maria@gmail.com', password: 'password')
      warehouse = Warehouse.create!(name: 'Galpãozão', code: 'COD', city: 'Cidade', address: 'Endereço, 2', 
      area: 10_000, description: 'Alguma descrição.', zipcode: '12346578')
      other_warehouse = Warehouse.create!(name: 'Galpão médio', code: 'DOC', city: 'Cidade2', address: 'Endereço_maior, 5', 
      area: 11_000, description: 'Alguma descrição a mais.', zipcode: '91011121')
      supplier = Supplier.create!(corporate_name: 'ACME Marcas ltda', brand_name:'ACME ltda', registration_number:'75443709000160', 
      address:'Rua Pamplona, 1083', city:'São Paulo', state:'SP', email:'contato@acme.com', phone: '1124384557')
      order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now.to_date, status: 'delivered')
      product = ProductModel.create!(name:'Produto A', weight: 1, width: 15, height: 20, depth: 30, sku:'PROD0A-SAMS-AWEF5', supplier: supplier)  
      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product)
      
      original_serial_number = stock_product.serial_number

      #Act
      stock_product.update!(warehouse: other_warehouse)

      #Assert
      expect(stock_product.serial_number).to eq(original_serial_number)
    end  
  end
  describe '#available?' do
    it 'true se não houver destino' do
      #Arrange
      user = User.create!(name: 'Maria silva', email: 'maria@gmail.com', password: 'password')
      warehouse = Warehouse.create!(name: 'Galpãozão', code: 'COD', city: 'Cidade', address: 'Endereço, 2', 
      area: 10_000, description: 'Alguma descrição.', zipcode: '12346578')
      supplier = Supplier.create!(corporate_name: 'ACME Marcas ltda', brand_name:'ACME ltda', registration_number:'75443709000160', 
      address:'Rua Pamplona, 1083', city:'São Paulo', state:'SP', email:'contato@acme.com', phone: '1124384557')

      order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now.to_date, status: 'delivered')

      product = ProductModel.create!(name:'Produto A', weight: 1, width: 15, height: 20, depth: 30, 
      sku:'PROD0A-SAMS-AWEF5', supplier: supplier)  
      
      #Act
      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product)
      
      #Assert
      expect(stock_product.available?).to eq true
    end
  end
end
