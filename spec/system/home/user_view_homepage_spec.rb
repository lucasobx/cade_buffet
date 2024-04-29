require 'rails_helper'

describe 'Visitante acessa a tela inicial' do
  it 'e vê o nome da aplicação' do
    visit root_path

    expect(page).to have_content 'Cade Buffet?'
    expect(page).to have_link 'Cade Buffet?', href: root_path
  end

  it 'e vê os buffets cadastrados' do
    first_owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
    second_owner = Owner.create!(name: 'Lara', email: 'lara@email.com', password: '87654321')
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
      owner: first_owner,
      payment_methods: [cash, pix])
    Buffet.create!(
      brand_name: 'Edecy Buffet',
      corporate_name: 'Edecy Buffet LTDA',
      registration_code: '55996244000122',
      phone_number: '(11)22229988',
      email: 'edecy@email.com',
      address: 'Rua Castilho, 560',
      neighborhood: 'Piratininga',
      city: 'Belo Horizonte',
      state: 'MG',
      postal_code: '55280-001',
      description: 'Buffet para festa infantil',
      owner: second_owner,
      payment_methods: [cash, pix])

    visit root_path

    expect(page).not_to have_content 'Não existem buffets cadastrados.'
    expect(page).to have_content 'Casamentos Buffet'
    expect(page).to have_content 'Sales, SP'
    expect(page).to have_content 'Edecy Buffet'
    expect(page).to have_content 'Belo Horizonte, MG'
  end

  it 'e não existem buffets cadastrados' do
    visit root_path

    expect(page).to have_content 'Não existem buffets cadastrados.'
  end
end