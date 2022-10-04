require 'rails_helper'

describe 'Usuário vê seus próprios pedidos' do
  it 'e deve estar autenticado' do
    # Arrange

    # Act
    visit root_url
    click_on 'Meus pedidos'

    # Assert
    expect(current_url).to eq(new_user_session_url)
  end

  it 'e não vê os pedidos de outros usuários' do
    # Arrange
    usuario1 = User.create!(name: 'Joana', email:'joana@email.com', password: 'password')
    usuario2 = User.create!(name: 'Pedro', email:'pedro@email.com', password: 'password')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100000,
                                  address: 'Avenida do aeroporto, 1000', zipcode: '07150000',
                                  description: 'Galpão destinado para cargas internacionais')

    supplier = Supplier.create!(corporate_name: 'Samsung eletronicos BR', brand_name:'Samsung', 
                                registration_number:'55394009000160', address:'Rua Três de Maio, 1083',
                                city:'Guarulhos', state:'SP', email:'contato@asamsung.com', phone: '1140044040')
    
    order1 = Order.create!(user: usuario1, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now.to_date, status: 'pending')
    order2 = Order.create!(user: usuario2, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.week.from_now, status: 'canceled')
    order11 = Order.create!(user: usuario1, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.month.from_now, status: 'delivered')

    # Act
    login_as(usuario1)
    visit root_url
    click_on 'Meus pedidos'

    # Assert
    expect(page).to have_content(order1.code)
    expect(page).to have_content('pendente')
    expect(page).not_to have_content('cancelado')
    expect(page).not_to have_content(order2.code)
    expect(page).to have_content(order11.code)
    expect(page).to have_content('entregue')

  end

  it 'e visita um pedido' do
    # Arrange
    usuario1 = User.create!(name: 'Joana', email:'joana@email.com', password: 'password')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100000,
                                  address: 'Avenida do aeroporto, 1000', zipcode: '07150000',
                                  description: 'Galpão destinado para cargas internacionais')

    supplier = Supplier.create!(corporate_name: 'Samsung eletronicos BR', brand_name:'Samsung', 
                                registration_number:'55394009000160', address:'Rua Três de Maio, 1083',
                                city:'Guarulhos', state:'SP', email:'contato@asamsung.com', phone: '1140044040')
    
    order1 = Order.create!(user: usuario1, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now.to_date)
    

    # Act
    login_as(usuario1)
    visit root_url
    click_on 'Meus pedidos'
    click_on order1.code

    # Assert
    expect(page).to have_content 'Detalhes do pedido'
    expect(page).to have_content order1.code
    expect(page).to have_content 'Galpão destino: GRU | Aeroporto SP'
    expect(page).to have_content 'Fornecedor: Samsung eletronicos BR'
    expect(page).to have_content "Data prevista de entrega: #{I18n.localize(1.day.from_now.to_date.to_date)}" #data formatada
  end

  it 'e não visita pedidos de outros usuários' do
    # Arrange
    usuario1 = User.create!(name: 'Joana', email:'joana@email.com', password: 'password')
    usuario2 = User.create!(name: 'Pedro', email:'pedro@email.com', password: 'password')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100000,
                                  address: 'Avenida do aeroporto, 1000', zipcode: '07150000',
                                  description: 'Galpão destinado para cargas internacionais')

    supplier = Supplier.create!(corporate_name: 'Samsung eletronicos BR', brand_name:'Samsung', 
                                registration_number:'55394009000160', address:'Rua Três de Maio, 1083',
                                city:'Guarulhos', state:'SP', email:'contato@asamsung.com', phone: '1140044040')
    
    order1 = Order.create!(user: usuario1, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now.to_date)
    

    # Act
    login_as(usuario2)
    visit order_url(order1.id) #tentar acessar pedido do outro usuario

    # Assert
    expect(current_url).not_to eq order_url(order1.id)
    expect(current_url).to eq(root_url)
    expect(page).to have_content('Você não tem permissão para acessar este pedido.')
  end

end