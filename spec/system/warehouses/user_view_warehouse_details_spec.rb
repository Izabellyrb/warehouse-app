require 'rails_helper'

describe 'usuario vê detalhes de um galpão' do
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

    it 'e vê informações adicionais' do
        # Arrange
        user = User.create!(name: 'Joana', email: 'joana@email.com', password: 'password')
        w = Warehouse.new(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100000,
                        address: 'Avenida do aeroporto, 1000', zipcode: '07150000',
                        description: 'Galpão destinado para cargas internacionais')
        w.save()

        # Act
        login_as(user)
        visit(root_url)
        click_on('Aeroporto SP')
        
        # Assert
        expect(page).to have_content('Galpão GRU')
        expect(page).to have_content('Nome: Aeroporto SP')
        expect(page).to have_content('Cidade: Guarulhos')
        expect(page).to have_content('Área: 100000 m²')
        expect(page).to have_content('Endereço: Avenida do aeroporto, 1000 CEP: 07150-000')
        expect(page).to have_content('Descrição: Galpão destinado para cargas internacionais')

    end

    it 'e volta para tela inicial' do
        # Arrange
        user = User.create!(name: 'Joana', email: 'joana@email.com', password: 'password')
        Warehouse.create(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100000,
                        address: 'Avenida do aeroporto, 1000', zipcode: '07150000',
                        description: 'Galpão destinado para cargas internacionais')

        # Act
        login_as(user)
        visit(root_url)
        click_on 'Aeroporto SP'
        click_on 'Voltar'

        # Assert
        expect(current_url).to eq(root_url)
    end
end