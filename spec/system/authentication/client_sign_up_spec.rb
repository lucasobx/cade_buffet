require 'rails_helper'

describe 'Cliente cria uma conta' do
  it 'com sucesso' do
    visit root_path
    click_on 'Entrar Como Cliente'
    click_on 'Criar uma conta'
    fill_in 'Nome', with: 'Julia'
    fill_in 'CPF', with: '94641091064'
    fill_in 'E-mail', with: 'julia@email.com'
    fill_in 'Senha', with: '12345678'
    fill_in 'Confirme sua senha', with: '12345678'
    click_on 'Criar Conta'

    expect(page).to have_content 'Boas Vindas! Você realizou seu registro com sucesso.'
    expect(page).to have_content 'Julia - julia@email.com'
    expect(page).to have_link 'Sair'
    client = Client.last
    expect(client.name).to eq 'Julia'
  end

  it 'e deve preencher todos os campos' do
    visit root_path
    click_on 'Entrar Como Cliente'
    click_on 'Criar uma conta'
    fill_in 'Nome', with: ''
    fill_in 'CPF', with: ''
    fill_in 'E-mail', with: 'julia@email.com'
    fill_in 'Senha', with: '12345678'
    fill_in 'Confirme sua senha', with: '12345678'
    click_on 'Criar Conta'

    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'CPF não pode ficar em branco'
  end
end