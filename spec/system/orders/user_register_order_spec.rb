require 'rails_helper'

describe 'Usuário cadastra um pedido' do
  it 'somente se estiver autenticado' do
    #Arrange

    #Act
    visit root_url
    within('nav') do
      click_on 'Registrar pedido'
    end
 
    #Assert
    expect(current_url).to eq(new_user_session_url)
  end

  it 'com sucesso' do
    #Arrange
    user = User.create!(name: 'Joana', email: 'joana@email.com', password: 'password')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100000,
                              address: 'Avenida do aeroporto, 1000', zipcode: '07150000',
                              description: 'Galpão destinado para cargas internacionais')
                
    Warehouse.create!(name: 'Galpão Maceio', code: 'MCZ', city: 'Maceio', address: 'Av. Rio verde, 1049', area: 50_000, 
    description: 'Galpão secundário localizado no interior do estado.', zipcode: '04700010')

    supplier = Supplier.create!(corporate_name: 'Samsung eletronicos BR', brand_name:'Samsung', 
                                registration_number:'55394009000160', address:'Rua Três de Maio, 1083',
                                city:'Guarulhos', state:'SP', email:'contato@asamsung.com', phone: '1140044040')
    Supplier.create!(corporate_name: 'ACME Industria Ltda.', brand_name:'ACME ltda', registration_number:'75443709000160',
    address:'Rua Pamplona, 1083', city:'São Paulo', state:'SP', email:'contato@acme.com', phone: '1124384557')
    
    allow(SecureRandom).to receive(:alphanumeric).and_return('ABC1234567')

    #Act
    login_as(user)
    visit root_url
    click_on 'Registrar pedido'
    select 'GRU | Aeroporto SP', from: 'Galpão destino'
    select supplier.full_supplier, from: 'Fornecedor'
    fill_in 'Data prevista de entrega', with: '20/12/2022'
    click_on 'Registrar'

    #Assert
    expect(page).to have_content 'Pedido registrado com sucesso!'
    expect(page).to have_content 'Pedido ABC1234567'
    expect(page).to have_content 'Galpão destino: GRU | Aeroporto SP'
    expect(page).to have_content 'Fornecedor: Samsung eletronicos BR'
    expect(page).to have_content 'Data prevista de entrega: 20/12/2022'
    expect(page).to have_content 'Usuário responsável: Joana <joana@email.com>'
    expect(page).not_to have_content 'Galpão destino: Galpão Maceio'
    expect(page).not_to have_content 'Fornecedor: ACME Industria Ltda.'
  end

  it 'e não informa a data de entrega' do
    #Arrange
    user = User.create!(name: 'Joana', email: 'joana@email.com', password: 'password')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100000,
                              address: 'Avenida do aeroporto, 1000', zipcode: '07150000',
                              description: 'Galpão destinado para cargas internacionais')

    supplier = Supplier.create!(corporate_name: 'Samsung eletronicos BR', brand_name:'Samsung', 
                                registration_number:'55394009000160', address:'Rua Três de Maio, 1083',
                                city:'Guarulhos', state:'SP', email:'contato@asamsung.com', phone: '1140044040')
    Supplier.create!(corporate_name: 'ACME Industria Ltda.', brand_name:'ACME ltda', registration_number:'75443709000160',
    address:'Rua Pamplona, 1083', city:'São Paulo', state:'SP', email:'contato@acme.com', phone: '1124384557')
    
    allow(SecureRandom).to receive(:alphanumeric).and_return('ABC1234567')

    #Act
    login_as(user)
    visit root_url
    click_on 'Registrar pedido'
    select 'GRU | Aeroporto SP', from: 'Galpão destino'
    select supplier.full_supplier, from: 'Fornecedor'
    fill_in 'Data prevista de entrega', with: ''
    click_on 'Registrar'

    #Assert
    expect(page).to have_content 'Não foi possível registrar o pedido'
    expect(page).to have_content 'Data prevista de entrega não pode ficar em branco'
    end
end