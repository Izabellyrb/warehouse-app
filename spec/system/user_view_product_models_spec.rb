require 'rails_helper'

describe 'Usuário vê modelos de produtos' do
  it 'a partir do menu' do
    #Arrange

    #Act
    visit root_url
    within('nav') do
      click_on 'Modelos de produtos'
    end

    #Assert
    expect(current_url).to eq(product_models_url)
  end

  it 'com sucesso' do
    #Arrange
    supplier = Supplier.create!(corporate_name: 'Samsung eletronicos BR', brand_name:'Samsung', registration_number:'55394009000160', address:'Rua Três de Maio, 1083', city:'Guarulhos', state:'SP', email:'contato@asamsung.com', phone: '1140044040')

    ProductModel.create!(name:'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku:'TV32-SAMS-SGHU2', supplier: supplier)
    ProductModel.create!(name:'Celular S20', weight: 15, width: 6, height: 19, depth: 2, 
                        sku:'CEL20-SAMS-AWEF5', supplier: supplier)

    #Act
    visit root_url
    within('nav') do
      click_on 'Modelos de produtos'
    end

    #Assert
    expect(page).to have_content('TV 32')
    expect(page).to have_content('TV32-SAMS-SGHU2')
    expect(page).to have_content('Samsung')
    expect(page).to have_content('Celular S20')
    expect(page).to have_content('CEL20-SAMS-AWEF5')
    expect(page).to have_content('Samsung')
  end

  it 'e não há produtos cadastrados' do
    #Arrange
    
    #Act
    visit root_url
    click_on 'Modelos de produtos'

    #Assert
    expect(page).to have_content('Não há produtos cadastrados')
  end
end