require 'rails_helper'

describe 'usuário edita galpão' do 
    it 'a partir da página de detalhes' do
        # Arrange
        Warehouse.create(name: 'Maceio', code: 'MCZ', city: 'Maceio', address: 'Av. Rio verde, 1049', 
        area: 50_000, description: 'Galpão secundário localizado no interior do estado.', zipcode: '04700010')

        # Act
        visit root_url
        click_on 'Maceio'
        click_on 'Editar Galpão'

        # Assert
        expect(page).to have_content('Editar Galpão')
        expect(page).to have_field('Nome', with: 'Maceio')
        expect(page).to have_field('Código', with: 'MCZ')
        expect(page).to have_field('Cidade', with: 'Maceio')
        expect(page).to have_field('Área', with: 50_000)
        expect(page).to have_field('Endereço', with: 'Av. Rio verde, 1049')
        expect(page).to have_field('CEP', with: '04700010')
        expect(page).to have_field('Descrição', with: 'Galpão secundário localizado no interior do estado.')
    end

    it 'com sucesso' do
        # Arrange
        Warehouse.create!(name: 'Maceio', code: 'MCZ', city: 'Maceio', address: 'Av. Rio verde, 1049', 
        area: 50_000, description: 'Galpão secundário localizado no interior do estado.', zipcode: '04700010')

        # Act
        visit root_url
        click_on 'Maceio'
        click_on 'Editar Galpão'
        fill_in 'Nome', with: 'Aeroporto de Maceio'
        fill_in 'Código', with: 'MCZ'
        fill_in 'Cidade', with: 'Maceio-AL'
        fill_in 'Área', with: '50000'
        fill_in 'Endereço', with: 'Av. Rio Verde, 1000'
        fill_in 'CEP', with: '04700011'
        fill_in 'Descrição', with: 'Galpão secundário localizado no litoral do estado.'
        click_on 'Enviar'

        # Assert
        expect(page).to have_content('Galpão atualizado com sucesso!')
        expect(page).to have_content('Nome: Aeroporto de Maceio')
        expect(page).to have_content('Aeroporto de Maceio')
        expect(page).to have_content('Código: MCZ')
        expect(page).to have_content('Cidade: Maceio-AL')
        expect(page).to have_content('Área: 50000 m²')
        expect(page).to have_content('Endereço: Av. Rio Verde, 1000')
        expect(page).to have_content('CEP: 04700011')
        expect(page).to have_content('Descrição: Galpão secundário localizado no litoral do estado.')
    end

    it 'e mantém os campos obrigatórios' do
        # Arrange
        Warehouse.create(name: 'Maceio', code: 'MCZ', city: 'Maceio', address: 'Av. Rio verde, 1049', 
        area: 50_000, description: 'Galpão secundário localizado no interior do estado.', zipcode: '04700010')

        # Act
        visit root_url
        click_on 'Maceio'
        click_on 'Editar Galpão'
        fill_in 'Nome', with: ''
        fill_in 'Código', with: ''
        fill_in 'Cidade', with: ''
        fill_in 'Área', with: ''
        fill_in 'Endereço', with: ''
        fill_in 'CEP', with: ''
        fill_in 'Descrição', with: ''
        click_on 'Enviar'

        # Assert
        expect(page).to have_content('Não foi possível atualizar o galpão.')
    end
end