require 'rails_helper'

describe 'Usuário se autentica' do
	it 'com sucesso' do
		#Arrange
    user = User.create!(email: 'maria@gmail.com', password: 'password')

		#Act
    login_as(user)
    visit(root_url)

    #Assert
    within('nav') do
      expect(page).to have_button 'Sair'
      expect(page).to have_content 'maria@gmail.com'
    end
  end

  it 'e faz logout' do
    #Arrange
    user = User.create!(email: 'maria@gmail.com', password: 'password')

    #Act
    login_as(user)
    visit(root_url)
    click_on 'Sair'

    #Assert
    expect(page).to have_link 'Entrar'
    expect(page).not_to have_button 'Sair'
    expect(page).not_to have_content 'maria@gmail.com'
  end

end
