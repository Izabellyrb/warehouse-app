require 'rails_helper'

describe 'Usuário cadastra um pedido' do
  it 'somente se estiver autenticado' do
    # Arrange
    user = User.create!(name: 'Joana', email: 'joana@email.com', password: 'password')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100000,
                              address: 'Avenida do aeroporto, 1000', zipcode: '07150000',
                              description: 'Galpão destinado para cargas internacionais')

    supplier = Supplier.create!(corporate_name: 'Samsung eletronicos BR', brand_name:'Samsung', 
                                registration_number:'55394009000160', address:'Rua Três de Maio, 1083',
                                city:'Guarulhos', state:'SP', email:'contato@asamsung.com', phone: '1140044040')
    order1 = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now.to_date)

    #Act
    visit edit_order_url(order1.id) 

    # Assert
    expect(current_url).to eq new_user_session_url
  end

  it 'com sucesso' do
    # Arrange
    user = User.create!(name: 'Joana', email: 'joana@email.com', password: 'password')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100000,
                              address: 'Avenida do aeroporto, 1000', zipcode: '07150000',
                              description: 'Galpão destinado para cargas internacionais')

    supplier = Supplier.create!(corporate_name: 'Samsung eletronicos BR', brand_name:'Samsung', 
                                registration_number:'55394009000160', address:'Rua Três de Maio, 1083',
                                city:'Guarulhos', state:'SP', email:'contato@asamsung.com', phone: '1140044040')

    supplier2 = Supplier.create!(corporate_name: 'Aguas Brancas Ltda', brand_name:'Aguas Brancas', 
    registration_number:'45394917083660', address:'Rua 15 de agosto, 100',
    city:'Santa Barbara', state:'SP', email:'contato@aguasbrancas.com', phone: '1140888888')
    
    order1 = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now.to_date)

  #Act
  login_as(user)
  visit root_url
  click_on 'Meus pedidos'
    click_on order1.code
    click_on 'Editar'
    fill_in 'Data prevista de entrega', with: '04-10-2022'
    select supplier2.corporate_name, from: 'Fornecedor'
    click_on 'Registrar'

    # Assert
    expect(page).to have_content('Pedido atualizado com sucesso!')
    expect(page).to have_content("Fornecedor: #{supplier2.corporate_name}")
    expect(page).to have_content("Data prevista de entrega: 04/10/2022")
  end

  it 'caso seja o responsável' do
    # Arrange
    user = User.create!(name: 'Joana', email: 'joana@email.com', password: 'password')
    user2 = User.create!(name: 'André', email: 'andre@email.com', password: 'password')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100000,
                              address: 'Avenida do aeroporto, 1000', zipcode: '07150000',
                              description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'Samsung eletronicos BR', brand_name:'Samsung', 
                                registration_number:'55394009000160', address:'Rua Três de Maio, 1083',
                                city:'Guarulhos', state:'SP', email:'contato@asamsung.com', phone: '1140044040')
    order1 = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now.to_date)

    #Act
    login_as(user2)
    visit edit_order_url(order1.id) 

    # Assert
    expect(current_url).to eq root_url
  end

end
