require 'rails_helper'

describe 'usuário cadastra um galpão' do
	it 'a partir da tela inicial' do
		#Arrange

		#Act
		visit root_url
		click_on 'Cadastrar Galpão'

		#Assert
		expect(page).to have_field('Nome')
		expect(page).to have_field('Código')
		expect(page).to have_field('Cidade')
		expect(page).to have_field('Área')
		expect(page).to have_field('Endereço')
		expect(page).to have_field('CEP')
		expect(page).to have_field('Descrição')
	end

	it 'com sucesso' do
		#Arrange

		#Act
		visit root_url
		click_on 'Cadastrar Galpão'
		fill_in 'Nome', with: 'Rio de Janeiro'
		fill_in 'Código', with: 'RIO'
		fill_in 'Cidade', with: 'Rio de Janeiro'
		fill_in 'Área', with: '32000'
		fill_in 'Endereço', with: 'Av. do Museu do Amanhã, 100'
		fill_in 'CEP', with: '20100000'
		fill_in 'Descrição', with: 'Galpão localizado no Rio de Janeiro capital.'
		click_on 'Enviar'

		#Assert
		expect(current_url).to eq(root_url)
		expect(page).to have_content 'Galpão cadastrado com sucesso!'
		expect(page).to have_content('Código: RIO')
		expect(page).to have_content('Cidade: Rio de Janeiro')
		expect(page).to have_content('32000 m²')
	end

	it 'com dados incompletos' do #teste de mensagem (se aparece erro)
		#Arrange

		#Act
		visit root_url
		click_on 'Cadastrar Galpão'
		fill_in 'Nome', with: ''
		fill_in 'Código', with: ''
		fill_in 'Descrição', with: ''
		fill_in 'CEP', with: ''
		click_on 'Enviar'

		#Assert
		expect(page).to have_content 'Galpão não cadastrado!'
		expect(page).to have_content 'Nome não pode ficar em branco'
		expect(page).to have_content 'Código não pode ficar em branco'
		expect(page).to have_content 'Descrição não pode ficar em branco'
		expect(page).to have_content 'CEP não possui o tamanho esperado (8 caracteres)'
	end
end
