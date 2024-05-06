require 'rails_helper'

describe 'Cliente faz pedido para um buffet' do
  it 'e deve estar autenticado' do
    owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
    cash = PaymentMethod.create!(name: 'Dinheiro')
    pix = PaymentMethod.create!(name: 'Pix')
    buffet = Buffet.create!(brand_name: 'Miniland', corporate_name: 'Miniland LTDA',
                            registration_code: '00556164220103', phone_number: '(11)32441110', email: 'miniland@email.com',
                            address: 'Av Martins, 50', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                            postal_code: '14770-070', description: 'Buffet especializado em festas temáticas',
                            owner: owner, payment_methods: [cash, pix])
    EventType.create!(name: 'Festa dos Heróis', description: 'Festa infantil com temática de heróis',
                      min_guests: 10, max_guests: 80, duration: 240,
                      menu_details: 'Doces, Salgados, Bebidas',
                      alcohol_option: false, decoration_option: true, parking_service_option: true,
                      location_option: true, buffet: buffet, base_price: 5000.0, extra_guest: 100.0,
                      extra_hour: 500.0, we_base_price: 8000.0, we_extra_guest: 200.0, we_extra_hour: 800.0)

    visit root_path
    click_on 'Miniland'
    click_on 'Agendar Festa dos Heróis'
    
    expect(current_path).to eq new_client_session_path
  end

  it 'a partir dos detalhes do evento' do
    client = Client.create!(name: 'Julia', personal_code: '94641091064', email: 'julia@email.com', password: '12345678')
    owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
    cash = PaymentMethod.create!(name: 'Dinheiro')
    pix = PaymentMethod.create!(name: 'Pix')
    buffet = Buffet.create!(brand_name: 'Miniland', corporate_name: 'Miniland LTDA',
                            registration_code: '00556164220103', phone_number: '(11)32441110', email: 'miniland@email.com',
                            address: 'Av Martins, 50', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                            postal_code: '14770-070', description: 'Buffet especializado em festas temáticas',
                            owner: owner, payment_methods: [cash, pix])
    EventType.create!(name: 'Festa dos Heróis', description: 'Festa infantil com temática de heróis',
                      min_guests: 10, max_guests: 80, duration: 240,
                      menu_details: 'Doces, Salgados, Bebidas',
                      alcohol_option: false, decoration_option: true, parking_service_option: true,
                      location_option: true, buffet: buffet, base_price: 5000.0, extra_guest: 100.0,
                      extra_hour: 500.0, we_base_price: 8000.0, we_extra_guest: 200.0, we_extra_hour: 800.0)

    login_as(client, scope: :client)
    visit root_path
    click_on 'Miniland'
    click_on 'Agendar Festa dos Heróis'

    expect(current_path).to eq new_order_path
  end

  it 'com dados incompletos' do
    client = Client.create!(name: 'Julia', personal_code: '94641091064', email: 'julia@email.com', password: '12345678')
    owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
    cash = PaymentMethod.create!(name: 'Dinheiro')
    pix = PaymentMethod.create!(name: 'Pix')
    buffet = Buffet.create!(brand_name: 'Miniland', corporate_name: 'Miniland LTDA',
                            registration_code: '00556164220103', phone_number: '(11)32441110', email: 'miniland@email.com',
                            address: 'Av Martins, 50', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                            postal_code: '14770-070', description: 'Buffet especializado em festas temáticas',
                            owner: owner, payment_methods: [cash, pix])
    EventType.create!(name: 'Festa dos Heróis', description: 'Festa infantil com temática de heróis',
                      min_guests: 10, max_guests: 80, duration: 240,
                      menu_details: 'Doces, Salgados, Bebidas',
                      alcohol_option: false, decoration_option: true, parking_service_option: true,
                      location_option: true, buffet: buffet, base_price: 5000.0, extra_guest: 100.0,
                      extra_hour: 500.0, we_base_price: 8000.0, we_extra_guest: 200.0, we_extra_hour: 800.0)

    login_as(client, scope: :client)
    visit root_path
    click_on 'Miniland'
    click_on 'Agendar Festa dos Heróis'
    fill_in 'Data', with: ''
    fill_in 'Número de Convidados', with: ''
    click_on 'Agendar Evento'
    
    expect(page).to have_content 'Não foi possível concluir o agendamento.'
    expect(page).to have_content 'Data não pode ficar em branco'
    expect(page).to have_content 'Número de Convidados não pode ficar em branco'
  end

  it 'com sucesso e seleção de local disponível' do
    client = Client.create!(name: 'Julia', personal_code: '94641091064', email: 'julia@email.com', password: '12345678')
    owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
    cash = PaymentMethod.create!(name: 'Dinheiro')
    pix = PaymentMethod.create!(name: 'Pix')
    buffet = Buffet.create!(brand_name: 'Miniland', corporate_name: 'Miniland LTDA',
                            registration_code: '00556164220103', phone_number: '(11)32441110', email: 'miniland@email.com',
                            address: 'Av Martins, 50', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                            postal_code: '14770-070', description: 'Buffet especializado em festas temáticas',
                            owner: owner, payment_methods: [cash, pix])
    EventType.create!(name: 'Festa dos Heróis', description: 'Festa infantil com temática de heróis',
                      min_guests: 10, max_guests: 80, duration: 240,
                      menu_details: 'Doces, Salgados, Bebidas',
                      alcohol_option: false, decoration_option: true, parking_service_option: true,
                      location_option: true, buffet: buffet, base_price: 5000.0, extra_guest: 100.0,
                      extra_hour: 500.0, we_base_price: 8000.0, we_extra_guest: 200.0, we_extra_hour: 800.0)

    login_as(client, scope: :client)
    visit root_path
    click_on 'Miniland'
    click_on 'Agendar Festa dos Heróis'
    fill_in 'Data', with: 7.days.from_now
    fill_in 'Número de Convidados', with: 30
    fill_in 'Informações Adicionais', with: 'Comemoração do aniversário do meu filho'
    fill_in 'Endereço', with: 'Rua da Praça, 273'
    click_on 'Agendar Evento'

    expect(current_path).to eq order_path(Order.last)
    expect(page).to have_content 'Agendamento realizado com sucesso!'
    expect(page).to have_content 'Festa dos Heróis'
    expect(page).to have_content "Data: #{I18n.localize(7.days.from_now.to_date)}"
    expect(page).to have_content 'Endereço: Rua da Praça, 273'
    expect(page).to have_content 'Informações Adicionais: Comemoração do aniversário do meu filho'
  end

  it 'com sucesso e seleção de local indisponível' do
    client = Client.create!(name: 'Julia', personal_code: '94641091064', email: 'julia@email.com', password: '12345678')
    owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
    cash = PaymentMethod.create!(name: 'Dinheiro')
    pix = PaymentMethod.create!(name: 'Pix')
    buffet = Buffet.create!(brand_name: 'Miniland', corporate_name: 'Miniland LTDA',
                            registration_code: '00556164220103', phone_number: '(11)32441110', email: 'miniland@email.com',
                            address: 'Av Martins, 50', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                            postal_code: '14770-070', description: 'Buffet especializado em festas temáticas',
                            owner: owner, payment_methods: [cash, pix])
    EventType.create!(name: 'Festa dos Heróis', description: 'Festa infantil com temática de heróis',
                      min_guests: 10, max_guests: 80, duration: 240,
                      menu_details: 'Doces, Salgados, Bebidas',
                      alcohol_option: false, decoration_option: true, parking_service_option: true,
                      location_option: false, buffet: buffet, base_price: 5000.0, extra_guest: 100.0,
                      extra_hour: 500.0, we_base_price: 8000.0, we_extra_guest: 200.0, we_extra_hour: 800.0)

    login_as(client, scope: :client)
    visit root_path
    click_on 'Miniland'
    click_on 'Agendar Festa dos Heróis'
    fill_in 'Data', with: 7.days.from_now
    fill_in 'Número de Convidados', with: 30
    fill_in 'Informações Adicionais', with: 'Comemoração do aniversário do meu filho'
    expect(page).not_to have_field 'Endereço'
    click_on 'Agendar Evento'

    expect(current_path).to eq order_path(Order.last)
    expect(page).to have_content 'Agendamento realizado com sucesso!'
    expect(page).to have_content 'Festa dos Heróis'
    expect(page).to have_content "Data: #{I18n.localize(7.days.from_now.to_date)}"
    expect(page).to have_content 'Endereço: Av Martins, 50 - Jardim do Sol, Sales - SP'
    expect(page).to have_content 'Informações Adicionais: Comemoração do aniversário do meu filho'
  end
end