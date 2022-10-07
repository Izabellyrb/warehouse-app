require 'rails_helper'

describe 'Usuário add itens ao pedido' do
  it 'com sucesso' do
    #Arrange
    user = User.create!(name: 'Joana', email: 'joana@email.com', password: 'password')
  
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100000,
                                address: 'Avenida do aeroporto, 1000', zipcode: '07150000',
                                description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'Samsung eletronicos BR', brand_name:'Samsung', 
                                registration_number:'55394009000160', address:'Rua Três de Maio, 1083',
                                city:'Guarulhos', state:'SP', email:'contato@asamsung.com', phone: '1140044040')
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now.to_date)

    product_a = ProductModel.create!(name:'Produto A', weight: 1, width: 15, height: 20, depth: 30, 
                                    sku:'PROD0A-SAMS-AWEF5', supplier: supplier)  
    product_b = ProductModel.create!(name:'Produto B', weight: 1, width: 15, height: 20, depth: 30, 
                                    sku:'PROD0B-SAMS-AWEF5', supplier: supplier)  
    #Act
    login_as(user)
    visit root_path
    click_on 'Meus pedidos'
    click_on order.code
    click_on 'Adicionar item'

    select 'Produto A', from: 'Produto'
    fill_in 'Quantidade', with: 8
    click_on 'Salvar'

    #Assert
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Item adicionado com sucesso!'
    expect(page).to have_content '8 x Produto A'
  end

  it 'e não vê itens de outro fornecedor' do
    #Arrange
    user = User.create!(name: 'Joana', email: 'joana@email.com', password: 'password')
  
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100000,
                                address: 'Avenida do aeroporto, 1000', zipcode: '07150000',
                                description: 'Galpão destinado para cargas internacionais')
    suppliera = Supplier.create!(corporate_name: 'Samsung eletronicos BR', brand_name:'Samsung', 
                                registration_number:'55394009000160', address:'Rua Três de Maio, 1083',
                                city:'Guarulhos', state:'SP', email:'contato@asamsung.com', phone: '1140044040')
    supplierb = Supplier.create!(corporate_name: 'ACME Industria Ltda.', brand_name:'ACME ltda', registration_number:'75443709000160',
    address:'Rua Pamplona, 1083', city:'São Paulo', state:'SP', email:'contato@acme.com', phone: '1124384557')
                                
    order = Order.create!(user: user, warehouse: warehouse, supplier: suppliera, estimated_delivery_date: 1.day.from_now.to_date)

    product_a = ProductModel.create!(name:'Produto A', weight: 1, width: 15, height: 20, depth: 30, 
                                    sku:'PROD0A-SAMS-AWEF5', supplier: suppliera)  
    product_b = ProductModel.create!(name:'Produto B', weight: 1, width: 15, height: 20, depth: 30, 
                                    sku:'PROD0B-SAMS-AWEF5', supplier: supplierb)  
    #Act
    login_as(user)
    visit root_path
    click_on 'Meus pedidos'
    click_on order.code
    click_on 'Adicionar item'

    #Assert
    expect(page).to have_content 'Produto A'
    expect(page).not_to have_content 'Produto B'
  end
end