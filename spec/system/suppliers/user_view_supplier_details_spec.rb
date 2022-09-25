require 'rails_helper'

describe 'Usuário acessa a pagina de um fornecedor' do
  it 'e vê detalhes adicionais do cadastro' do
    # Arrange
    Supplier.create!(corporate_name: 'ACME Industria Ltda.', brand_name:'ACME ltda', registration_number:'75443709000160', 
    address:'Rua Pamplona, 1083', city:'São Paulo', state:'SP', email:'contato@acme.com', phone: '1124384557')

    # Act
    visit(suppliers_url)
    click_on('ACME ltda')

    # Assert
    expect(page).to have_content('Fornecedor ACME ltda')
    expect(page).to have_content('Endereço: Rua Pamplona, 1083 - São Paulo - SP')
    expect(page).to have_content('Telefone: (11) 2438-4557')

  end

  it 'e volta para tela inicial' do
    # Arrange
    Supplier.create!(corporate_name: 'ACME Industria Ltda.', brand_name:'ACME ltda', registration_number:'75443709000160', 
    address:'Rua Pamplona, 1083', city:'São Paulo', state:'SP', email:'contato@acme.com', phone: '1124384557')

    # Act
    visit(suppliers_url)
    click_on('ACME ltda')
    click_on('Voltar')

    # Assert
    expect(current_url).to eq(suppliers_url)
  end
end