require 'rails_helper'

describe 'Usuário acessa a página de fornecedores' do
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

  it 'através do menu' do
    # Arrange
    user = User.create!(name: 'Joana', email: 'joana@email.com', password: 'password')
    
    # Act
    login_as(user)
    visit(root_url)
    within('nav') do
      click_on 'Fornecedores'
    end

    # Assert
    expect(current_url).to eq(suppliers_url)
  end

  it 'e vê fonecedores cadastrados' do 
    # Arrange
    user = User.create!(name: 'Joana', email: 'joana@email.com', password: 'password')

    Supplier.create!(corporate_name: 'ACME Industria Ltda.', brand_name:'ACME ltda', registration_number:'75443709000160', 
                    address:'Rua Pamplona, 1083', city:'São Paulo', state:'SP', email:'contato@acme.com', phone: '1124384557')
    Supplier.create!(corporate_name: 'Stella e Regina Transportes ME', brand_name:'SR Transportes', registration_number:'15152295000199', 
                    address:'Av. Condessa Elisabeth, 5500', city:'Bauru', state:'SP', email:'producao@stellaereginatransportesme.com.br', phone: '1127199140')
    
    # Act
    login_as(user)
    visit(root_url)
    within('nav') do
      click_on 'Fornecedores'
    end

    # Assert
    expect(page).not_to have_content('Não existem fornecedores cadastrados')
    expect(page).to have_content('Fornecedores')
    expect(page).to have_content('ACME ltda')
    expect(page).to have_content('São Paulo - SP')
    expect(page).to have_content('SR Transportes')
    expect(page).to have_content('Bauru - SP')
  end

  it 'e não há fornecedores cadastrados' do 
    # Arrange
    user = User.create!(name: 'Joana', email: 'joana@email.com', password: 'password')

    # Act
    login_as(user)
    visit(root_url)
    within('nav') do
      click_on 'Fornecedores'
    end

    # Assert
    expect(page).to have_content('Não há fornecedores cadastrados')
  end
end