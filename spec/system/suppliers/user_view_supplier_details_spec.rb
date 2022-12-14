require 'rails_helper'

describe 'Usuário acessa a pagina de um fornecedor' do
  it 'somente se estiver autenticado' do
    #Arrange

    #Act
    visit root_url
    within('nav') do
      click_on 'Fornecedores'
    end
 
    #Assert
    expect(current_url).to eq(new_user_session_url)
  end

  it 'e vê detalhes adicionais do cadastro' do
    # Arrange
    user = User.create!(name: 'Joana', email: 'joana@email.com', password: 'password')
    Supplier.create!(corporate_name: 'ACME Industria Ltda.', brand_name:'ACME ltda', registration_number:'75443709000160', 
    address:'Rua Pamplona, 1083', city:'São Paulo', state:'SP', email:'contato@acme.com', phone: '1124384557')

    # Act
    login_as(user)
    visit(suppliers_url)
    click_on('ACME ltda')

    # Assert
    expect(page).to have_content('Fornecedor ACME ltda')
    expect(page).to have_content('Endereço: Rua Pamplona, 1083 - São Paulo - SP')
    expect(page).to have_content('Telefone: (11) 2438-4557')

  end

  it 'e vê modelos de produtos do fornecedor' do
    # Arrange
    user = User.create!(name: 'Joana', email: 'joana@email.com', password: 'password')
    supplier = Supplier.create!(corporate_name: 'ACME Industria Ltda.', brand_name:'ACME ltda', registration_number:'75443709000160', 
    address:'Rua Pamplona, 1083', city:'São Paulo', state:'SP', email:'contato@acme.com', phone: '1124384557')

    ProductModel.create!(name:'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku:'TV32-SAMS-SGHU2', supplier: supplier)

    # Act
    login_as(user)
    visit(suppliers_url)
    click_on('ACME ltda')

    # Assert
    expect(page).to have_content('Modelos de produtos deste fornecedor')
    expect(page).to have_content('Modelo de produto: TV 32')
    expect(page).to have_content('TV32-SAMS-SGHU2')

  end

  it 'e não há produtos cadastrados' do
    #Arrange
    user = User.create!(name: 'Joana', email: 'joana@email.com', password: 'password')
    supplier = Supplier.create!(corporate_name: 'ACME Industria Ltda.', brand_name:'ACME ltda', registration_number:'75443709000160', 
    address:'Rua Pamplona, 1083', city:'São Paulo', state:'SP', email:'contato@acme.com', phone: '1124384557')
    
    #Act
    login_as(user)
    visit(suppliers_url)
    click_on('ACME ltda')

    #Assert
    expect(page).to have_content('Modelos de produtos deste fornecedor')
    expect(page).to have_content('Não há modelos de produtos cadastrados para este fornecedor')
  end


  it 'e volta para tela inicial' do
    # Arrange
    user = User.create!(name: 'Joana', email: 'joana@email.com', password: 'password')
    Supplier.create!(corporate_name: 'ACME Industria Ltda.', brand_name:'ACME ltda', registration_number:'75443709000160', 
    address:'Rua Pamplona, 1083', city:'São Paulo', state:'SP', email:'contato@acme.com', phone: '1124384557')

    # Act
    login_as(user)
    visit(suppliers_url)
    click_on('ACME ltda')
    click_on('Voltar')

    # Assert
    expect(current_url).to eq(suppliers_url)
  end
end