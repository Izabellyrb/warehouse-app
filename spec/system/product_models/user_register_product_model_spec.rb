require 'rails_helper'

describe 'Usuário cadastra um modelo de produto' do
  it 'com sucesso' do
    #Arrange
    supplier = Supplier.create!(corporate_name: 'Samsung eletronicos BR', brand_name:'Samsung', registration_number:'55394009000160', address:'Rua Três de Maio, 1083', city:'Guarulhos', state:'SP', email:'contato@asamsung.com', phone: '1140044040')

    other_supplier = Supplier.create!(corporate_name: 'M&A Entregas Expressas Ltda', brand_name:'M&A Express', registration_number:'64827572000121', address:'Rua Vera Pimentel Amorim, 159', city:'Aracruz', state:'ES', email:'adm@meaexpress.com.br', phone: '2727862646')

    #Act
    visit(root_url)
    click_on('Modelos de produtos')
    click_on('Cadastrar modelos de produtos')
    fill_in 'Nome', with: 'TV 40 polegadas'
    fill_in 'Peso', with: 10_000
    fill_in 'Altura', with: 90
    fill_in 'Largura', with: 60
    fill_in 'Profundidade', with: 10
    fill_in 'SKU', with: 'TV40-SAMS-VHD8'
    select 'Samsung', from: 'Fornecedor'
    click_on 'Enviar'

    #Assert
    expect(page).to have_content('Modelo de produto cadastrado com sucesso!')
    expect(page).to have_content('TV 40 polegadas')
    expect(page).to have_content('SKU: TV40-SAMS-VHD8')
    expect(page).to have_content('Dimensões: 60 cm x 90 cm x 10 cm')
  end

  it 'deve preencher todos os campos' do
    #Arrange
    supplier = Supplier.create!(corporate_name: 'Samsung eletronicos BR', brand_name:'Samsung', registration_number:'55394009000160', address:'Rua Três de Maio, 1083', city:'Guarulhos', state:'SP', email:'contato@asamsung.com', phone: '1140044040')

    #Act
    visit(root_url)
    click_on('Modelos de produtos')
    click_on('Cadastrar modelos de produtos')
    fill_in 'Nome', with: ''
    fill_in 'Peso', with: ''
    fill_in 'SKU', with: ''
    fill_in 'Largura', with: 0
    click_on 'Enviar'

    #Assert
    expect(page).to have_content('Não foi possível cadastrar o modelo de produto.')
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('SKU não pode ficar em branco')
    expect(page).to have_content('Largura deve ser maior que 0')
  end
end
