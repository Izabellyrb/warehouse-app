require 'rails_helper'

describe 'usuário vê o estoque' do
  it 'na tela do galpão' do
    #Arrange
    user = User.create!(name: 'Joana', email: 'joana@email.com', password: 'password')
    supplier = Supplier.create!(corporate_name: 'Samsung eletronicos BR', brand_name:'Samsung',
                                registration_number:'55394009000160', address:'Rua Três de Maio, 1083', 
                                city:'Guarulhos', state:'SP', email:'contato@asamsung.com', phone: '1140044040')
    warehouse = Warehouse.create(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100000,
                                 address: 'Avenida do aeroporto, 1000', zipcode: '07150000',
                                 description: 'Galpão destinado para cargas internacionais')
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    product1 = ProductModel.create!(name:'TV 32', weight: 8000, width: 70, height: 45, depth: 10,
                        sku:'TV32-SAMS-SGHU2', supplier: supplier)
    product2 = ProductModel.create!(name:'Celular S20', weight: 15, width: 6, height: 19, depth: 2, 
                        sku:'CEL20-SAMS-AWEF5', supplier: supplier)
    product3 = ProductModel.create!(name:'Notebook K23', weight: 2000, width: 40, height: 9, depth: 20, 
                        sku:'NOTE45-SAMS-ASDF8', supplier: supplier)

    3.times {StockProduct.create!(order: order, warehouse: warehouse, product_model: product1)}
    2.times {StockProduct.create!(order: order, warehouse: warehouse, product_model: product3)}

    #Act
    login_as(user)
    visit root_url
    click_on 'Aeroporto SP'

    #Assert
    expect(page).to have_content('Galpão GRU')
    within('section#stock_products') do
      expect(page).to have_content('Itens em Estoque')
      expect(page).to have_content('3 x TV32-SAMS-SGHU2')
      expect(page).to have_content('2 x NOTE45-SAMS-ASDF8')
      expect(page).not_to have_content('CEL20-SAMS-AWEF5')
    end
  end
  it 'e da baixa em um item' do
    #Arrange
    user = User.create!(name: 'Joana', email: 'joana@email.com', password: 'password')
    supplier = Supplier.create!(corporate_name: 'Samsung eletronicos BR', brand_name:'Samsung',
                                registration_number:'55394009000160', address:'Rua Três de Maio, 1083', 
                                city:'Guarulhos', state:'SP', email:'contato@asamsung.com', phone: '1140044040')
    warehouse = Warehouse.create(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100000,
                                  address: 'Avenida do aeroporto, 1000', zipcode: '07150000',
                                  description: 'Galpão destinado para cargas internacionais')
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    product1 = ProductModel.create!(name:'TV 32', weight: 8000, width: 70, height: 45, depth: 10,
                        sku:'TV32-SAMS-SGHU2', supplier: supplier)

    2.times {StockProduct.create!(order: order, warehouse: warehouse, product_model: product1)}

    #Act
    login_as(user)
    visit root_url
    click_on 'Aeroporto SP'
    select 'TV32-SAMS-SGHU2', from: 'Item para saída'
    fill_in 'Destinatário', with: 'Maria Ferreira'
    fill_in 'Endereço destino', with: 'Rua 7 de Setembro, 150 - Campinas - SP'
    click_on 'Confirmar retirada'

    #Assert
    expect(current_url).to eq warehouse_url(warehouse.id)
    expect(page).to have_content('Item retirado com sucesso!')
    expect(page).to have_content('1 x TV32-SAMS-SGHU2')
  end

end
