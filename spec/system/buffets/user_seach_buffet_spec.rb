require 'rails_helper'

describe 'Visitante busca por um buffet' do
  it 'a partir do menu' do
    visit root_path

    within 'nav' do
      expect(page).to have_field 'Buscar Buffet'
      expect(page).to have_button 'Buscar'
    end
  end

  it 'e encontra um buffet' do
    owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
    cash = PaymentMethod.create!(name: 'Dinheiro')
    pix = PaymentMethod.create!(name: 'Pix')
    buffet = Buffet.create!(brand_name: 'Casamentos Buffet', corporate_name: 'Casamentos Buffet LTDA',
                            registration_code: '73456164000100', phone_number: '(11)00001111',
                            email: 'casabuffet@email.com', address: 'Av Machado, 650', neighborhood: 'Jardim do Sol',
                            city: 'Sales', state: 'SP', postal_code: '14980-970',
                            description: 'Buffet especializado em casamentos', owner: owner, payment_methods: [cash, pix])
    EventType.create!(name: 'Festa de Casamento', description: 'Espaço luxuoso e confortável', min_guests: 15,
                      max_guests: 150, duration: 240, menu_details: 'Doces, Salgados, Bebidas', alcohol_option: true,
                      decoration_option: true, parking_service_option: true, location_option: false, buffet: buffet,
                      base_price: 10000.0, extra_guest: 250.0, extra_hour: 1000.0, we_base_price: 15000.0,
                      we_extra_guest: 400.0, we_extra_hour: 1500.0)

    visit root_path
    fill_in 'Buscar Buffet', with: 'Casamentos Buffet'
    click_on 'Buscar'

    expect(page).to have_content 'Resultados da Busca por: Casamentos Buffet'
    expect(page).to have_content '1 buffet encontrado'
    expect(page).to have_content 'Casamentos Buffet'
    expect(page).to have_content 'Sales, SP'
  end

  it 'e encontra múltiplos pedidos' do
    f_owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
    s_owner = Owner.create!(name: 'Bianca', email: 'bianca@email.com', password: '12345678')
    t_owner = Owner.create!(name: 'Julio', email: 'julio@email.com', password: '12345678')
    cash = PaymentMethod.create!(name: 'Dinheiro')
    pix = PaymentMethod.create!(name: 'Pix')
    f_buffet = Buffet.create!(brand_name: 'Casamentos Buffet', corporate_name: 'Casamentos Buffet LTDA',
                            registration_code: '73456164000100', phone_number: '(11)00001111',
                            email: 'casabuffet@email.com', address: 'Av Machado, 650', neighborhood: 'Jardim do Sol',
                            city: 'Sales', state: 'SP', postal_code: '14980-970',
                            description: 'Buffet especializado em casamentos', owner: f_owner, payment_methods: [cash, pix])
    EventType.create!(name: 'Festa de Casamento', description: 'Espaço luxuoso e confortável', min_guests: 15,
                      max_guests: 150, duration: 240, menu_details: 'Doces, Salgados, Bebidas', alcohol_option: true,
                      decoration_option: true, parking_service_option: true, location_option: false, buffet: f_buffet,
                      base_price: 10000.0, extra_guest: 250.0, extra_hour: 1000.0, we_base_price: 15000.0,
                      we_extra_guest: 400.0, we_extra_hour: 1500.0)
    s_buffet = Buffet.create!(brand_name: 'La Luna Casamentos', corporate_name: 'La Luna Casamentos LTDA',
                            registration_code: '63001164000100', phone_number: '(11)22223333',
                            email: 'laluna@email.com', address: 'Av Pinheiros, 50', neighborhood: 'Pinheiros',
                            city: 'São Paulo', state: 'SP', postal_code: '05680-970',
                            description: 'Buffet especializado em casamentos', owner: s_owner, payment_methods: [cash, pix])
    EventType.create!(name: 'Festa de Casamento', description: 'Festa de casamento', min_guests: 15,
                      max_guests: 150, duration: 240, menu_details: 'Doces, Salgados, Bebidas', alcohol_option: true,
                      decoration_option: true, parking_service_option: true, location_option: false, buffet: s_buffet,
                      base_price: 10000.0, extra_guest: 250.0, extra_hour: 1000.0, we_base_price: 15000.0,
                      we_extra_guest: 400.0, we_extra_hour: 1500.0)
    t_buffet = Buffet.create!(brand_name: 'Edecy Buffet', corporate_name: 'Edecy Buffet LTDA',
                            registration_code: '00432264000199', phone_number: '(11)55557777',
                            email: 'casabuffet@email.com', address: 'Rua Castilho, 560', neighborhood: 'Piratininga',
                            city: 'Belo Horizonte', state: 'MG', postal_code: '55280-001',
                            description: 'Buffet especializado em festa infantil', owner: t_owner, payment_methods: [cash, pix])
    EventType.create!(name: 'Festa à fantasia', description: 'Festa com fantasias e comida', min_guests: 15,
                      max_guests: 150, duration: 240, menu_details: 'Doces, Salgados, Bebidas', alcohol_option: false,
                      decoration_option: true, parking_service_option: true, location_option: true, buffet: t_buffet,
                      base_price: 5000.0, extra_guest: 150.0, extra_hour: 400.0, we_base_price: 8000.0,
                      we_extra_guest: 200.0, we_extra_hour: 600.0)
      
    visit root_path
    fill_in 'Buscar Buffet', with: 'Casamentos'
    click_on 'Buscar'

    expect(page).to have_content '2 buffets encontrados'
    expect(page).to have_content 'Casamentos Buffet'
    expect(page).to have_content 'La Luna Casamentos'
    expect(page).not_to have_content 'Edecy Buffet'
  end
end