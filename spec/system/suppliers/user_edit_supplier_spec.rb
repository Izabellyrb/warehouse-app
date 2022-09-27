require 'rails_helper'

describe 'Usuário edita cadastro de fornecedor' do
  it 'a partir da página de detalhes de fornecedores' do
    #Arrange
    Supplier.create!(corporate_name: 'ACME Industria Ltda.', brand_name:'ACME ltda', registration_number:'75443709000160', 
      address:'Rua Pamplona, 1083', city:'São Paulo', state:'SP', email:'contato@acme.com', phone: '1124384557')

    #Act
    visit(suppliers_url)
    click_on('ACME ltda')
    click_on('Editar Fornecedor')

    #Assert
    expect(page).to have_content('Editar Fornecedor')
    expect(page).to have_field('Razão social', with: 'ACME Industria Ltda.')
    expect(page).to have_field('Nome fantasia', with: 'ACME ltda')
    expect(page).to have_field('Telefone', with: '1124384557')
  end

  it 'com sucesso' do
    #Arrange
    Supplier.create!(corporate_name: 'ACME Industria Ltda.', brand_name:'ACME ltda', registration_number:'75443709000160', 
      address:'Rua Pamplona, 1083', city:'São Paulo', state:'SP', email:'contato@acme.com', phone: '1124384557')

    #Act
    visit(suppliers_url)
    click_on('ACME ltda')
    click_on('Editar Fornecedor')
    fill_in 'Razão social', with: 'ACME Industria e Comercio ltda'
    fill_in 'Nome fantasia', with: 'ACME IC ltda'
    fill_in 'Telefone', with: '1124000048'
    click_on 'Enviar'

    #Assert
    expect(page).to have_content('Fornecedor atualizado com sucesso!')
    expect(page).to have_content('Fornecedor ACME IC ltda')
    expect(page).to have_content('Razão social: ACME Industria e Comercio ltda')
    expect(page).to have_content('Telefone: (11) 2400-0048')
  end
end