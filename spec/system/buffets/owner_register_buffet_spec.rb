require 'rails_helper'

describe 'dono de buffet cadastra um buffet' do
  it 'e deve estar autenticado' do
    visit new_buffet_path

    expect(current_path).to eq new_owner_session_path
  end

  it 'e não vê link meu buffet até que tenha um buffet cadastrado' do
    owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')

    login_as owner, scope: :owner
    visit new_buffet_path

    expect(page).not_to have_link 'Meu Buffet'
  end

  it 'com sucesso' do
    owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
    PaymentMethod.create!(name: 'Cartão de Crédito')
    PaymentMethod.create!(name: 'Pix')

    login_as owner, scope: :owner
    visit root_path
    fill_in 'Nome Fantasia', with: 'Casamentos Buffet'
    fill_in 'Razão Social', with: 'Casamentos Buffet LTDA'
    fill_in 'CNPJ', with: '73456164000100'
    fill_in 'Telefone', with: '(11)00001111'
    fill_in 'E-mail', with: 'casabuffet@email.com'
    fill_in 'Endereço', with: 'Av Machado, 650'
    fill_in 'Bairro', with: 'Jardim do Sol'
    fill_in 'Cidade', with: 'Sales'
    fill_in 'Estado', with: 'SP'
    fill_in 'CEP', with: '14980-970'
    fill_in 'Descrição', with: 'Buffet especializado em casamentos'
    check 'Pix'
    click_on 'Enviar'

    expect(page).to have_content 'Buffet cadastrado com sucesso.'
    expect(page).to have_content 'Casamentos Buffet'
    expect(page).to have_content 'Sales, SP'
    expect(page).to have_link 'Meu Buffet'
  end

  it 'e deve preencher todos os campos' do
    owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
    PaymentMethod.create!(name: 'Cartão de Crédito')
    PaymentMethod.create!(name: 'Pix')

    login_as owner, scope: :owner
    visit root_path
    fill_in 'Nome Fantasia', with: ''
    fill_in 'Razão Social', with: ''
    click_on 'Enviar'

    expect(page).to have_content 'Não foi possível cadastrar o Buffet.'
    expect(page).to have_content 'Nome Fantasia não pode ficar em branco'
    expect(page).to have_content 'Razão Social não pode ficar em branco'
  end

  it 'e não pode cadastrar um segundo buffet' do
    owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
    credit = PaymentMethod.create!(name: 'Cartão de Crédito')
    cash = PaymentMethod.create!(name: 'Dinheiro')
    Buffet.create!(brand_name: 'Casamentos Buffet', corporate_name: 'Casamentos Buffet LTDA',
                   registration_code: '73456164000100', phone_number: '(11)00001111', email: 'casabuffet@email.com',
                   address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                   postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                   owner: owner, payment_methods: [credit, cash])
    
    login_as owner, scope: :owner
    visit new_buffet_path

    expect(current_path).to eq root_path
    expect(page).to have_content 'Você já cadastrou um buffet.'
  end
end