require 'rails_helper'

describe 'Dono de Buffet cria uma conta' do
  it 'com sucesso' do
    visit root_path
    click_on 'Dono de Buffet'
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

  it 'e deve preencher todos os campos' do
    visit root_path
    click_on 'Dono de Buffet'
    click_on 'Criar uma conta'
    fill_in 'Nome', with: ''
    fill_in 'E-mail', with: 'jorge@email.com'
    fill_in 'Senha', with: '12345678'
    fill_in 'Confirme sua senha', with: '12345678'
    click_on 'Criar Conta'

    expect(page).to have_content 'Nome não pode ficar em branco'
  end

  it 'e é redirecionado para o cadastro de buffet' do
    visit root_path
    click_on 'Dono de Buffet'
    click_on 'Criar uma conta'
    fill_in 'Nome', with: 'Jorge'
    fill_in 'E-mail', with: 'jorge@email.com'
    fill_in 'Senha', with: '12345678'
    fill_in 'Confirme sua senha', with: '12345678'
    click_on 'Criar Conta'
    click_on 'Cade Buffet?'

    expect(current_path).to eq new_buffet_path
    expect(page).to have_content 'Cadastre seu buffet antes de prosseguir.'
    expect(page).to have_content 'Novo Buffet'
  end
end