require 'rails_helper'

describe 'Visitante busca por um buffet' do
  it 'a partir do menu' do
    visit root_path

    within 'nav' do
      expect(page).to have_field 'Buscar Buffet'
      expect(page).to have_button 'Buscar'
    end
  end

  it 'e encontra um buffet buscando pelo nome' do
    owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
    cash = PaymentMethod.create!(name: 'Dinheiro')
    pix = PaymentMethod.create!(name: 'Pix')
    buffet = Buffet.create!(brand_name: 'Casamentos Buffet', corporate_name: 'Casamentos Buffet LTDA',
                            registration_code: '73456164000100', phone_number: '(11)00001111', email: 'casabuffet@email.com',
                            address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                            postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                            owner: owner, payment_methods: [cash, pix])
    EventType.create!(name: 'Festa de Casamento', description: 'Espaço luxuoso e confortável', min_guests: 15,
                      max_guests: 150, duration: 240, menu_details: 'Doces, Salgados, Bebidas', alcohol_option: true,
                      decoration_option: true, parking_service_option: true, location_option: false, buffet: buffet,
                      base_price: 10000.0, extra_guest: 250.0, extra_hour: 1000.0, we_base_price: 15000.0,
                      we_extra_guest: 400.0, we_extra_hour: 1500.0)

    visit root_path
    fill_in 'Buscar Buffet', with: buffet.brand_name
    click_on 'Buscar'

    expect(page).to have_content 'Resultados da Busca por: Casamentos Buffet'
    expect(page).to have_content '1 buffet encontrado'
    expect(page).to have_content 'Casamentos Buffet'
    expect(page).to have_content 'Sales, SP'
  end

  it 'e encontra um buffet buscando por cidade' do
    owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
    cash = PaymentMethod.create!(name: 'Dinheiro')
    pix = PaymentMethod.create!(name: 'Pix')
    buffet = Buffet.create!(brand_name: 'Casamentos Buffet', corporate_name: 'Casamentos Buffet LTDA',
                            registration_code: '73456164000100', phone_number: '(11)00001111', email: 'casabuffet@email.com',
                            address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                            postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                            owner: owner, payment_methods: [cash, pix])
    EventType.create!(name: 'Festa de Casamento', description: 'Espaço luxuoso e confortável', min_guests: 15,
                      max_guests: 150, duration: 240, menu_details: 'Doces, Salgados, Bebidas', alcohol_option: true,
                      decoration_option: true, parking_service_option: true, location_option: false, buffet: buffet,
                      base_price: 10000.0, extra_guest: 250.0, extra_hour: 1000.0, we_base_price: 15000.0,
                      we_extra_guest: 400.0, we_extra_hour: 1500.0)

    visit root_path
    fill_in 'Buscar Buffet', with: buffet.city
    click_on 'Buscar'

    expect(page).to have_content 'Resultados da Busca por: Sales'
    expect(page).to have_content '1 buffet encontrado'
    expect(page).to have_content 'Casamentos Buffet'
    expect(page).to have_content 'Sales, SP'    
  end

  it 'e encontra um buffet buscando por tipo de evento' do
    owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
    cash = PaymentMethod.create!(name: 'Dinheiro')
    pix = PaymentMethod.create!(name: 'Pix')
    buffet = Buffet.create!(brand_name: 'Amanita Buffet', corporate_name: 'Amanita Buffet LTDA',
                            registration_code: '73456164000100', phone_number: '(11)00001111', email: 'casabuffet@email.com',
                            address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                            postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                            owner: owner, payment_methods: [cash, pix])
    event = EventType.create!(name: 'Festa de Casamento', description: 'Espaço luxuoso e confortável', min_guests: 15,
                              max_guests: 150, duration: 240, menu_details: 'Doces, Salgados, Bebidas', alcohol_option: true,
                              decoration_option: true, parking_service_option: true, location_option: false, buffet: buffet,
                              base_price: 10000.0, extra_guest: 250.0, extra_hour: 1000.0, we_base_price: 15000.0,
                              we_extra_guest: 400.0, we_extra_hour: 1500.0)

    visit root_path
    fill_in 'Buscar Buffet', with: event.name
    click_on 'Buscar'

    expect(page).to have_content 'Resultados da Busca por: Festa de Casamento'
    expect(page).to have_content '1 buffet encontrado'
    expect(page).to have_content 'Amanita Buffet'
    expect(page).to have_content 'Sales, SP'    
  end

  it 'e encontra múltiplos buffets listados em ordem alfabética' do
    owner1 = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
    owner2 = Owner.create!(name: 'Bianca', email: 'bianca@email.com', password: '12345678')
    owner3 = Owner.create!(name: 'Julio', email: 'julio@email.com', password: '12345678')
    owner4 = Owner.create!(name: 'Joao', email: 'joao@email.com', password: '12345678')
    cash = PaymentMethod.create!(name: 'Dinheiro')
    pix = PaymentMethod.create!(name: 'Pix')
    buffet2 = Buffet.create!(brand_name: 'La Luna Casamentos', corporate_name: 'La Luna Casamentos LTDA',
                             registration_code: '63001164000100', phone_number: '(11)22223333', email: 'laluna@email.com',
                             address: 'Av Pinheiros, 50', neighborhood: 'Pinheiros', city: 'São Paulo', state: 'SP',
                             postal_code: '05680-970', description: 'Buffet especializado em casamentos',
                             owner: owner2, payment_methods: [cash, pix])
    EventType.create!(name: 'Festa de Casamento', description: 'Festa de casamento', min_guests: 15,
                      max_guests: 150, duration: 240, menu_details: 'Doces, Salgados, Bebidas', alcohol_option: true,
                      decoration_option: true, parking_service_option: true, location_option: false, buffet: buffet2,
                      base_price: 10000.0, extra_guest: 250.0, extra_hour: 1000.0, we_base_price: 15000.0,
                      we_extra_guest: 400.0, we_extra_hour: 1500.0)
    buffet1 = Buffet.create!(brand_name: 'Casamentos Buffet', corporate_name: 'Casamentos Buffet LTDA',
                             registration_code: '73456164000100', phone_number: '(11)00001111', email: 'casabuffet@email.com',
                             address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                             postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                             owner: owner1, payment_methods: [cash, pix])
    EventType.create!(name: 'Festa de Casamento', description: 'Espaço luxuoso e confortável', min_guests: 15,
                      max_guests: 150, duration: 240, menu_details: 'Doces, Salgados, Bebidas', alcohol_option: true,
                      decoration_option: true, parking_service_option: true, location_option: false, buffet: buffet1,
                      base_price: 10000.0, extra_guest: 250.0, extra_hour: 1000.0, we_base_price: 15000.0,
                      we_extra_guest: 400.0, we_extra_hour: 1500.0)
    buffet3 = Buffet.create!(brand_name: 'Edecy Buffet', corporate_name: 'Edecy Buffet LTDA',
                             registration_code: '00432264000199', phone_number: '(11)55557777', email: 'casabuffet@email.com',
                             address: 'Rua Castilho, 560', neighborhood: 'Piratininga', city: 'Belo Horizonte', state: 'MG',
                             postal_code: '55280-001', description: 'Buffet especializado em festa infantil',
                             owner: owner3, payment_methods: [cash, pix])
    EventType.create!(name: 'Festa à fantasia', description: 'Festa com fantasias e comida', min_guests: 15,
                      max_guests: 150, duration: 240, menu_details: 'Doces, Salgados, Bebidas', alcohol_option: false,
                      decoration_option: true, parking_service_option: true, location_option: true, buffet: buffet3,
                      base_price: 5000.0, extra_guest: 150.0, extra_hour: 400.0, we_base_price: 8000.0,
                      we_extra_guest: 200.0, we_extra_hour: 600.0)
    buffet4 = Buffet.create!(brand_name: 'A Moda Inglesa', corporate_name: 'À Moda Inglesa LTDA',
                             registration_code: '72200334000177', phone_number: '(11)54321110', email: 'modaing@email.com',
                             address: 'Av Machado, 30', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                             postal_code: '14980-800', description: 'Buffet especializado em casamentos',
                             owner: owner4, payment_methods: [cash, pix])
    EventType.create!(name: 'Festa de Casamento', description: 'Opção formal e refinada, apreciada por anfitriões mais exigentes',
                      min_guests: 15, max_guests: 150, duration: 240, menu_details: 'Doces, Salgados, Bebidas',
                      alcohol_option: true, decoration_option: true, parking_service_option: true, location_option: false, 
                      buffet: buffet4, base_price: 10000.0, extra_guest: 250.0, extra_hour: 1000.0, we_base_price: 15000.0,
                      we_extra_guest: 400.0, we_extra_hour: 1500.0)
      
    visit root_path
    fill_in 'Buscar Buffet', with: 'Casamento'
    click_on 'Buscar'

    expect(page).to have_content '3 buffets encontrados'
    within '#buffets > div:nth-child(1)' do
      expect(page).to have_content 'A Moda Inglesa'
    end
    within '#buffets > div:nth-child(2)' do
      expect(page).to have_content 'Casamentos Buffet'
    end
    within '#buffets > div:nth-child(3)' do
      expect(page).to have_content 'La Luna Casamentos'
    end
    expect(page).not_to have_content 'Edecy Buffet'
  end

  it 'e retorna para a página inicial' do
    owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
    cash = PaymentMethod.create!(name: 'Dinheiro')
    pix = PaymentMethod.create!(name: 'Pix')
    buffet = Buffet.create!(brand_name: 'Casamentos Buffet', corporate_name: 'Casamentos Buffet LTDA',
                            registration_code: '73456164000100', phone_number: '(11)00001111', email: 'casabuffet@email.com',
                            address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                            postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                            owner: owner, payment_methods: [cash, pix])

    visit root_path
    fill_in 'Buscar Buffet', with: buffet.brand_name
    click_on 'Buscar'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end
end