require 'rails_helper'

describe 'usuário remove UM galpão' do
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

    it 'com sucesso' do
        #Arrange
        user = User.create!(name: 'Joana', email: 'joana@email.com', password: 'password')
        Warehouse.create!(name: 'Cuiaba', code: 'CWB', city: 'Cuiaba', address: 'Av. Principal, 19', 
        area: 11_000, description: 'Galpão no centro do país.', zipcode: '56000000')

        #Act
        login_as(user)
        visit root_url
        click_on 'Cuiaba'
        click_on 'Remover'

        #Assert
        expect(current_url).to eq(root_url)
        expect(page).to have_content('Galpão removido com sucesso!')
        expect(page).not_to have_content('Cuiaba')
        expect(page).not_to have_content('CWB')
    end

    it 'e não apaga outros galpões' do
        #Arrange
        user = User.create!(name: 'Joana', email: 'joana@email.com', password: 'password')
        w1 = Warehouse.create!(name: 'Cuiaba', code: 'CWB', city: 'Cuiaba', address: 'Av. Principal, 19', 
        area: 11_000, description: 'Galpão no centro do país.', zipcode: '56000000')
        w2 = Warehouse.create!(name: 'Belo Horizonte', code: 'BHE', city: 'Belo Horizonte', address: 'Av. da Nação, 2045', 
        area: 91_000, description: 'Galpão no interior da cidade, para itens grandes .', zipcode: '21000000')

        #Act
        login_as(user)
        visit root_url
        click_on 'Cuiaba'
        click_on 'Remover'

        #Assert
        expect(current_url).to eq(root_url)
        expect(page).to have_content('Galpão removido com sucesso!')
        expect(page).to have_content('Belo Horizonte')
        expect(page).not_to have_content('Cuiaba')

    end
end