require 'rails_helper'

describe 'Dono de Buffet se autentica' do
  it 'com sucesso' do
    owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
    cash = PaymentMethod.create!(name: 'Dinheiro')
    pix = PaymentMethod.create!(name: 'Pix')
    Buffet.create!(
      brand_name: 'Casamentos Buffet',
      corporate_name: 'Casamentos Buffet LTDA',
      registration_code: '73456164000100',
      phone_number: '(11)00001111',
      email: 'casabuffet@email.com',
      address: 'Av Machado, 650',
      neighborhood: 'Jardim do Sol',
      city: 'Sales',
      state: 'SP',
      postal_code: '14980-970',
      description: 'Buffet especializado em casamentos',
      owner: owner,
      payment_methods: [cash, pix])

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