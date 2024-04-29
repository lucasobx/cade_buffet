require 'rails_helper'

describe 'Cliente se autentica' do
  it 'com sucesso' do
    Client.create!(name: 'Julia', personal_code: '94641091064', email: 'julia@email.com', password: '12345678')

    visit root_path
    click_on 'Entrar Como Cliente'
    within 'form' do
      fill_in 'E-mail', with: 'julia@email.com'
      fill_in 'Senha', with: '12345678'
      click_on 'Entrar'
    end

    expect(page).to have_content 'Login efetuado com sucesso.'
    within 'nav' do
      expect(page).not_to have_link 'Entrar Como Cliente'
      expect(page).to have_link 'Sair'
      expect(page).to have_content 'Julia - julia@email.com'
    end
  end

  it 'e faz logout' do
    Client.create!(name: 'Julia', personal_code: '94641091064', email: 'julia@email.com', password: '12345678')

    visit root_path
    click_on 'Entrar Como Cliente'
    within 'form' do
      fill_in 'E-mail', with: 'julia@email.com'
      fill_in 'Senha', with: '12345678'
      click_on 'Entrar'
    end
    click_on 'Sair'

    expect(page).to have_content 'Logout efetuado com sucesso.'
    expect(page).to have_link 'Entrar Como Cliente'
    expect(page).not_to have_link 'Sair'
    expect(page).not_to have_content 'Julia - julia@email.com'
  end
end