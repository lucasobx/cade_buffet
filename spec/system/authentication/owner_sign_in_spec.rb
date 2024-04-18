require 'rails_helper'

describe 'Dono de Buffet se autentica' do
  it 'com sucesso' do
    Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')

    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in 'E-mail', with: 'jorge@email.com'
      fill_in 'Senha', with: '12345678'
      click_on 'Entrar'
    end

    expect(page).to have_content 'Login efetuado com sucesso.'
    within('nav') do
      expect(page).not_to have_link 'Entrar'
      expect(page).to have_link'Sair'
      expect(page).to have_content 'Jorge - jorge@email.com'
    end
  end

  it 'e faz logout' do
    Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')

    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in 'E-mail', with: 'jorge@email.com'
      fill_in 'Senha', with: '12345678'
      click_on 'Entrar'
    end
    click_on 'Sair'

    expect(page).to have_content 'Logout efetuado com sucesso.'
    expect(page).to have_link 'Entrar'
    expect(page).not_to have_link 'Sair'
    expect(page).not_to have_content 'jorge@email.com'
  end
end