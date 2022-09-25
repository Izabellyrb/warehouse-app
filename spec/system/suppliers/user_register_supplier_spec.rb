require 'rails_helper'

describe 'Usuário cadastra um novo fornecedor' do
  it 'a partir da tela inicial' do
    #Arrange

		#Act
    visit(suppliers_url)
    click_on('Cadastrar fornecedores')

		#Assert
    expect(page).to have_field('Razão social')
		expect(page).to have_field('Nome fantasia')
		expect(page).to have_field('CNPJ')

  end

  it 'com sucesso' do
    #Arrange

		#Act
    visit(suppliers_url)
    click_on('Cadastrar fornecedores')
    fill_in 'Razão social', with: 'ACME Industria Ltda.'
    fill_in 'Nome fantasia', with: 'ACME ltda'
    fill_in 'CNPJ', with: '75443709000160'
    fill_in 'Endereço', with: 'Rua Pamplona, 1083'
    fill_in 'Cidade', with: 'São Paulo'
    fill_in 'Estado', with: 'SP'
    fill_in 'Email', with: 'contato@acme.com'
    fill_in 'Telefone', with: '1124384557'
    click_on 'Enviar'

		#Assert
    expect(current_url).to eq(suppliers_url)
		expect(page).to have_content('Fornecedor cadastrado com sucesso!')
		expect(page).to have_content('ACME ltda')
		expect(page).to have_content('São Paulo - SP')

  end

  it 'com dados incompletos' do
    #Arrange

		#Act
    visit(suppliers_url)
		click_on 'Cadastrar fornecedores'
		fill_in 'Razão social', with: ''
    fill_in 'Nome fantasia', with: ''
    fill_in 'CNPJ', with: ''
		click_on 'Enviar'

		#Assert
		expect(page).to have_content 'Fornecedor não cadastrado!'
		expect(page).to have_content "Razão social não pode ficar em branco"
		expect(page).to have_content "Nome fantasia não pode ficar em branco"
		expect(page).to have_content "CNPJ não pode ficar em branco"
		expect(page).to have_content "Email não pode ficar em branco"
		expect(page).to have_content "CNPJ não possui o tamanho esperado (14 caracteres)"
	end
end