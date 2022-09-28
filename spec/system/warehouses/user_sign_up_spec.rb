require 'rails_helper'

describe 'Usuário se autentica' do
	it 'com sucesso' do
		#Arrange
  
		#Act
    visit root_url
    click_on 'Entrar'
    click_on 'Criar uma conta'
    fill_in 'Nome', with: 'Joana'
    fill_in 'E-mail', with: 'joana@email.com'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Criar conta'

    #Assert
    expect(page).to have_content 'Boas vindas! Você realizou seu registro com sucesso.'
    expect(page).to have_content 'joana@email.com'
    expect(User.last.name).to eq 'Joana'
    expect(page).to have_button 'Sair'
  end

end
