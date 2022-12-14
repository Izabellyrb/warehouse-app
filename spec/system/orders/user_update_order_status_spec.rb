require 'rails_helper'

describe 'Usuário informa novo status de pedido' do
  it 'e pedido foi entregue' do
    # Arrange
    user = User.create!(name: 'Joana', email: 'joana@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100000,
                              address: 'Avenida do aeroporto, 1000', zipcode: '07150000',
                              description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'Samsung eletronicos BR', brand_name:'Samsung', 
                                registration_number:'55394009000160', address:'Rua Três de Maio, 1083',
                                city:'Guarulhos', state:'SP', email:'contato@asamsung.com', phone: '1140044040')
    
    product = ProductModel.create!(supplier: supplier, name: 'Cadeira Gamer', weight: 5, height: 100, width: 70, 
                                  depth: 75, sku: 'CAD-GAMER-1324')

    order1 = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now.to_date, 
                          status: :pending)

    order_item = OrderItem.create!(order: order1, product_model: product, quantity: 5)

    #Act
    login_as(user)
    visit root_url
    click_on 'Meus pedidos'
    click_on order1.code
    click_on 'Marcar como entregue'

    # Assert
    expect(current_url).to eq order_url(order1.id)
    expect(page).to have_content('Status do pedido: entregue')
    expect(page).not_to have_button('Marcar como cancelado')
    expect(page).not_to have_button('Marcar como entregue')
    expect(StockProduct.count).to eq 5
    expect(StockProduct.where(product_model: product, warehouse: warehouse).count).to eq 5
  end

  it 'e pedido foi cancelado' do
    # Arrange
    user = User.create!(name: 'Joana', email: 'joana@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100000,
                              address: 'Avenida do aeroporto, 1000', zipcode: '07150000',
                              description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'Samsung eletronicos BR', brand_name:'Samsung', 
                                registration_number:'55394009000160', address:'Rua Três de Maio, 1083',
                                city:'Guarulhos', state:'SP', email:'contato@asamsung.com', phone: '1140044040')
    product = ProductModel.create!(supplier: supplier, name: 'Cadeira Gamer', weight: 5, height: 100, width: 70, 
    depth: 75, sku: 'CAD-GAMER-1324')
    order1 = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now.to_date, 
                          status: :pending) 
    order_item = OrderItem.create!(order: order1, product_model: product, quantity: 5)

    #Act
    login_as(user)
    visit root_url
    click_on 'Meus pedidos'
    click_on order1.code
    click_on 'Marcar como cancelado'

    # Assert
    expect(current_url).to eq order_url(order1.id)
    expect(page).to have_content('Status do pedido: cancelado')
    expect(StockProduct.count).to eq 0
  end
end

