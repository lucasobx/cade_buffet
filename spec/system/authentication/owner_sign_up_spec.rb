require 'rails_helper'

describe 'Dono de Buffet cria uma conta' do
  it 'com sucesso' do
    visit root_path
    click_on 'Entrar'
    click_on 'Criar uma conta'
    fill_in 'Nome', with: 'Jorge'
    fill_in 'E-mail', with: 'jorge@email.com'
    fill_in 'Senha', with: '12345678'
    fill_in 'Confirme sua senha', with: '12345678'
    click_on 'Criar Conta'

    expect(page).to have_content 'Boas Vindas! Você realizou seu registro com sucesso.'
    expect(page).to have_content 'Jorge - jorge@email.com'
    expect(page).to have_link 'Sair'
    owner = Owner.last
    expect(owner.name).to eq 'Jorge'
  end
end