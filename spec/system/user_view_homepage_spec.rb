require 'rails_helper'

describe 'usuario visita tela inicial' do
    it 'e vê o nome da app' do
        # Arrange (unico que pode estar vazio, se for o caso)

        # Act
        visit ('/')

        # Assert
        expect(page).to have_content('Galpões & Estoque')
    end
    
end