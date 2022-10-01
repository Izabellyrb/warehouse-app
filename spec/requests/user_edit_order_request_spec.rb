require 'rails_helper'

describe 'Usuário edita um pedido' do
  it 'e não está autenticado' do
    # Arrange
    user = User.create!(name: 'Joana', email: 'joana@email.com', password: 'password')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100000,
                              address: 'Avenida do aeroporto, 1000', zipcode: '07150000',
                              description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'Samsung eletronicos BR', brand_name:'Samsung', 
                                registration_number:'55394009000160', address:'Rua Três de Maio, 1083',
                                city:'Guarulhos', state:'SP', email:'contato@asamsung.com', phone: '1140044040')
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now.to_date)

    #Act
    patch(order_url(order.id), params: {order: {supplier_id: 3}})

    # Assert
    expect(response).to redirect_to(new_user_session_url)
  end
  
  it 'e está autenticado, mas não é o dono' do
    # Arrange
    user = User.create!(name: 'Joana', email: 'joana@email.com', password: 'password')
    user2 = User.create!(name: 'André', email: 'andre@email.com', password: 'password')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100000,
                              address: 'Avenida do aeroporto, 1000', zipcode: '07150000',
                              description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'Samsung eletronicos BR', brand_name:'Samsung', 
                                registration_number:'55394009000160', address:'Rua Três de Maio, 1083',
                                city:'Guarulhos', state:'SP', email:'contato@asamsung.com', phone: '1140044040')
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now.to_date)

    #Act
    login_as(user2)
    patch(order_url(order.id), params: {order: {supplier_id: 3}})

    # Assert
    expect(response).to redirect_to(root_url)
  end
end