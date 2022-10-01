require 'rails_helper'

describe 'Usuário busca por pedido' do
  it 'a partir do menu' do
    #Arrange
    user = User.create!(name: 'Joana', email:'joana@email.com', password: 'password')
    #Act
    login_as(user)
    visit root_url

    #Assert
    within('nav') do
      expect(page).to have_field('Buscar pedido')
      expect(page).to have_button('Buscar')
    end
  end
  it 'se estiver autenticado' do
    #Arrange
    
    #Act
    visit root_url

    #Assert
    within('nav') do
      expect(page).not_to have_field('Buscar pedido')
      expect(page).not_to have_button('Buscar')
    end
  end
  it 'e encontra um pedido' do
    #Arrange
    user = User.create!(name: 'Joana', email:'joana@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100000,
                              address: 'Avenida do aeroporto, 1000', zipcode: '07150000',
                              description: 'Galpão destinado para cargas internacionais')

    supplier = Supplier.create!(corporate_name: 'Samsung eletronicos BR', brand_name:'Samsung', 
                                registration_number:'55394009000160', address:'Rua Três de Maio, 1083',
                                city:'Guarulhos', state:'SP', email:'contato@asamsung.com', phone: '1140044040')
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
   
    #Act
    login_as(user)
    visit root_url
    fill_in 'Buscar pedido', with: order.code
    click_on 'Buscar'

    #Assert
    expect(page).to have_content("Resultados da busca por: #{order.code}")
    expect(page).to have_content('1 pedido encontrado')
    expect(page).to have_content("Código: #{order.code}")
    expect(page).to have_content("Fornecedor: Samsung eletronicos BR")
    expect(page).to have_content("Galpão destino: GRU | Aeroporto SP")
  end

  it 'e encontra múltiplos pedidos' do
    #Arrange
    user = User.create!(name: 'Joana', email:'joana@email.com', password: 'password')
    
    first_warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100000,
                              address: 'Avenida do aeroporto, 1000', zipcode: '07150000',
                              description: 'Galpão destinado para cargas internacionais')

    second_warehouse = Warehouse.create!(name: 'Galpão do Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                              address: 'Rua do Aeroporto, 100', zipcode: '01000000',
                              description: 'Galpão localizado dentro do Aeroporto principal.')
    
    supplier = Supplier.create!(corporate_name: 'Samsung eletronicos BR', brand_name:'Samsung', 
                                registration_number:'55394009000160', address:'Rua Três de Maio, 1083',
                                city:'Guarulhos', state:'SP', email:'contato@asamsung.com', phone: '1140044040')
   
    allow(SecureRandom).to receive(:alphanumeric).and_return('GRU1234567')
    f_order = Order.create!(user: user, warehouse: first_warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
   
    allow(SecureRandom).to receive(:alphanumeric).and_return('GRU1985735')
    s_order = Order.create!(user: user, warehouse: first_warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

    allow(SecureRandom).to receive(:alphanumeric).and_return('SDU1000096')
    t_order = Order.create!(user: user, warehouse: second_warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)


    #Act
    login_as(user)
    visit root_url
    fill_in 'Buscar pedido', with: 'GRU'
    click_on 'Buscar'

    #Assert
    expect(page).to have_content('2 pedidos encontrados')
    expect(page).to have_content('GRU1234567')
    expect(page).to have_content("GRU1985735")
    expect(page).to have_content("Galpão destino: GRU | Aeroporto SP")
    expect(page).not_to have_content("SDU1000096")
    expect(page).not_to have_content("Galpão destino: SDU | Galpão do Rio")

  end
end