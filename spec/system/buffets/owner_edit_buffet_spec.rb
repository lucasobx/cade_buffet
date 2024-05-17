require 'rails_helper'

describe 'Dono de Buffet edita um buffet' do
  it 'e deve estar autenticado' do
    owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
    credit = PaymentMethod.create!(name: 'Cartão de Crédito')
    cash = PaymentMethod.create!(name: 'Dinheiro')
    buffet = Buffet.create!(brand_name: 'Casamentos Buffet', corporate_name: 'Casamentos Buffet LTDA',
                   registration_code: '73456164000100', phone_number: '(11)00001111', email: 'casabuffet@email.com',
                   address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                   postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                   owner: owner, payment_methods: [credit, cash])
    
    visit edit_buffet_path(buffet)

    expect(current_path).to eq new_owner_session_path
  end

  it 'a partir da página de detalhes' do
    owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
    credit = PaymentMethod.create!(name: 'Cartão de Crédito')
    cash = PaymentMethod.create!(name: 'Dinheiro')
    Buffet.create!(brand_name: 'Casamentos Buffet', corporate_name: 'Casamentos Buffet LTDA',
                   registration_code: '73456164000100', phone_number: '(11)00001111', email: 'casabuffet@email.com',
                   address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                   postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                   owner: owner, payment_methods: [credit, cash])
    
    login_as owner, scope: :owner
    visit root_path
    click_on 'Meu Buffet'
    click_on 'Editar'

    expect(page).to have_content 'Editar Buffet'
    expect(page).to have_field 'Nome Fantasia', with: 'Casamentos Buffet'
    expect(page).to have_field 'Razão Social', with: 'Casamentos Buffet LTDA'
    expect(page).to have_field 'CNPJ', with: '73456164000100'
    expect(page).to have_field 'Telefone', with: '(11)00001111'
    expect(page).to have_field 'E-mail', with: 'casabuffet@email.com'
    expect(page).to have_field 'Endereço', with: 'Av Machado, 650'
    expect(page).to have_field 'Bairro', with: 'Jardim do Sol'
    expect(page).to have_field 'Cidade', with: 'Sales'
    expect(page).to have_field 'Estado', with: 'SP'
    expect(page).to have_field 'CEP', with: '14980-970'
    expect(page).to have_field 'Descrição', with: 'Buffet especializado em casamentos'
    expect(page).to have_content 'Cartão de Crédito'
    expect(page).to have_content 'Dinheiro'
  end

  it 'com sucesso' do
    owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
    credit = PaymentMethod.create!(name: 'Cartão de Crédito')
    cash = PaymentMethod.create!(name: 'Dinheiro')
    Buffet.create!(brand_name: 'Casamentos Buffet', corporate_name: 'Casamentos Buffet LTDA',
                   registration_code: '73456164000100', phone_number: '(11)00001111', email: 'casabuffet@email.com',
                   address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                   postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                   owner: owner, payment_methods: [credit, cash])
    
    login_as owner, scope: :owner
    visit root_path
    click_on 'Meu Buffet'
    click_on 'Editar'
    fill_in 'Nome Fantasia', with: 'Casa Buffet'
    fill_in 'Endereço', with: 'Av Pedra Grande, 55'
    uncheck 'Dinheiro'
    click_on 'Enviar'

    expect(page).to have_content 'Buffet atualizado com sucesso.'
    expect(page).to have_content 'Casa Buffet'
    expect(page).to have_content 'Endereço: Av Pedra Grande, 55 - Jardim do Sol, Sales - SP - 14980-970'
    expect(page).to have_content 'Cartão de Crédito'
    expect(page).not_to have_content 'Dinheiro'
  end

  it 'e deve preencher todos os campos' do
    owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
    credit = PaymentMethod.create!(name: 'Cartão de Crédito')
    cash = PaymentMethod.create!(name: 'Dinheiro')
    Buffet.create!(brand_name: 'Casamentos Buffet', corporate_name: 'Casamentos Buffet LTDA',
                   registration_code: '73456164000100', phone_number: '(11)00001111', email: 'casabuffet@email.com',
                   address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                   postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                   owner: owner, payment_methods: [credit, cash])
    
    login_as owner, scope: :owner
    visit root_path
    click_on 'Meu Buffet'
    click_on 'Editar'
    fill_in 'Nome Fantasia', with: ''
    fill_in 'Endereço', with: ''
    click_on 'Enviar'

    expect(page).to have_content 'Não foi possível atualizar o buffet.'
    expect(page).to have_content 'Nome Fantasia não pode ficar em branco'
    expect(page).to have_content 'Endereço não pode ficar em branco'
  end

  it 'e não consegue editar o buffet de outro usuário' do
    owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
    second_owner = Owner.create!(name: 'Julia', email: 'julia@email.com', password: '45688520')
    credit = PaymentMethod.create!(name: 'Cartão de Crédito')
    cash = PaymentMethod.create!(name: 'Dinheiro')
    buffet = Buffet.create!(brand_name: 'Casamentos Buffet', corporate_name: 'Casamentos Buffet LTDA',
                            registration_code: '73456164000100', phone_number: '(11)00001111', email: 'casabuffet@email.com',
                            address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                            postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                            owner: owner, payment_methods: [credit, cash])
    Buffet.create!(brand_name: 'Edecy Buffet', corporate_name: 'Edecy Buffet LTDA',
                   registration_code: '55996244000122', phone_number: '(11)22229988', email: 'edecy@email.com',
                   address: 'Rua Castilho, 560', neighborhood: 'Piratininga', city: 'Belo Horizonte', state: 'MG',
                   postal_code: '55280-001', description: 'Buffet especializado em festa infantil',
                   owner: second_owner, payment_methods: [credit, cash])

      login_as second_owner, scope: :owner
      visit edit_buffet_path(buffet)
      
      expect(current_path).not_to eq edit_buffet_path(buffet)
      expect(current_path).to eq root_path
  end

  it 'e retorna para os detalhes do buffet' do
    owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
    credit = PaymentMethod.create!(name: 'Cartão de Crédito')
    cash = PaymentMethod.create!(name: 'Dinheiro')
    buffet = Buffet.create!(brand_name: 'Casamentos Buffet', corporate_name: 'Casamentos Buffet LTDA',
                            registration_code: '73456164000100', phone_number: '(11)00001111', email: 'casabuffet@email.com',
                            address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                            postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                            owner: owner, payment_methods: [credit, cash])
    
    login_as owner, scope: :owner
    visit root_path
    click_on 'Meu Buffet'
    click_on 'Editar'
    click_on 'Voltar'

    expect(current_path).to eq buffet_path(buffet)
  end
end