require 'rails_helper'

describe 'usuario visita tela inicial' do
    it 'e vê o nome da app' do
        # Arrange (unico que pode estar vazio, se for o caso)

        # Act
        visit (root_url)

        # Assert
        expect(page).to have_content('Galpões & Estoque')
    end

    it 'e vê os galpões cadastrados' do
        # Arrange
        #cadastrar 2 galpoes: Rio e Maceio
        Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', address: 'Rua do Aeroporto, 100', 
                         area: 60_000, description: 'Galpão localizado dentro do Aeroporto principal.', zipcode: '01000000')
        Warehouse.create!(name: 'Maceio', code: 'MCZ', city: 'Maceio', address: 'Av. Rio verde, 1049', 
                         area: 50_000, description: 'Galpão secundário localizado no interior do estado.', zipcode: '04700010')

        # Act
        visit(root_url)

        # Assert

        expect(page).to have_content('Rio')
        expect(page).to have_content('Código: SDU')
        expect(page).to have_content('Cidade: Rio de Janeiro')
        expect(page).to have_content('60000 m²')
        expect(page).to have_content('Maceio')
        expect(page).to have_content('Código: MCZ')
        expect(page).to have_content('Cidade: Maceio')
        expect(page).to have_content('50000 m²')
    end

    it 'e não existem galpões cadastrados' do
        # Arrange

        # Act
        visit(root_url)

        # Assert
        expect(page).to have_content('Não existem galpões cadastrados')
    end
end