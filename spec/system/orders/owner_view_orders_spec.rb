require 'rails_helper'

describe 'Dono de Buffet vê lista de pedidos' do
  it 'e deve estar autenticado' do
    joao = Client.create!(name: 'Joao', personal_code: '94641091064', email: 'joao@email.com', password: '12345678')
    owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
    cash = PaymentMethod.create!(name: 'Dinheiro')
    pix = PaymentMethod.create!(name: 'Pix')
    buffet = Buffet.create!(brand_name: 'Miniland', corporate_name: 'Miniland LTDA',
                            registration_code: '00556164220103', phone_number: '(11)32441110', email: 'miniland@email.com',
                            address: 'Av Martins, 50', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                            postal_code: '14770-070', description: 'Buffet especializado em festas temáticas',
                            owner: owner, payment_methods: [cash, pix])
    event = EventType.create!(name: 'Festa dos Heróis', description: 'Festa infantil com temática de heróis',
                              min_guests: 10, max_guests: 80, duration: 240,
                              menu_details: 'Doces, Salgados, Bebidas',
                              alcohol_option: false, decoration_option: true, parking_service_option: true,
                              location_option: true, buffet: buffet, base_price: 5000.0, extra_guest: 100.0,
                              extra_hour: 500.0, we_base_price: 8000.0, we_extra_guest: 200.0, we_extra_hour: 800.0)
    Order.create!(client: joao, buffet: buffet, event_type: event, event_date: 1.day.from_now,
                  estimated_guests: 30, event_details: 'Festa de aniversário', event_address: 'Rua da Praça, 273')

    visit buffet_orders_path

    expect(current_path).to eq new_owner_session_path
  end

  it 'e vê lista de pedidos' do
    joao = Client.create!(name: 'Joao', personal_code: '94641091064', email: 'joao@email.com', password: '12345678')
    maria = Client.create!(name: 'Maria', personal_code: '95551091000', email: 'maria@email.com', password: '12345678')
    owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
    cash = PaymentMethod.create!(name: 'Dinheiro')
    pix = PaymentMethod.create!(name: 'Pix')
    buffet = Buffet.create!(brand_name: 'Miniland', corporate_name: 'Miniland LTDA',
                            registration_code: '00556164220103', phone_number: '(11)32441110', email: 'miniland@email.com',
                            address: 'Av Martins, 50', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                            postal_code: '14770-070', description: 'Buffet especializado em festas temáticas',
                            owner: owner, payment_methods: [cash, pix])
    event1 = EventType.create!(name: 'Festa dos Heróis', description: 'Festa infantil com temática de heróis',
                               min_guests: 10, max_guests: 80, duration: 240,
                               menu_details: 'Doces, Salgados, Bebidas',
                               alcohol_option: false, decoration_option: true, parking_service_option: true,
                               location_option: true, buffet: buffet, base_price: 5000.0, extra_guest: 100.0,
                               extra_hour: 500.0, we_base_price: 8000.0, we_extra_guest: 200.0, we_extra_hour: 800.0)
    event2 = EventType.create!(name: 'Piscina de Bolinhas', description: 'Festa infantil com fantasias',
                               min_guests: 10, max_guests: 50, duration: 120,
                               menu_details: 'Doces, Salgados',
                               alcohol_option: false, decoration_option: true, parking_service_option: true,
                               location_option: true, buffet: buffet, base_price: 5000.0, extra_guest: 100.0,
                               extra_hour: 500.0, we_base_price: 8000.0, we_extra_guest: 200.0, we_extra_hour: 800.0)
    
    order1 = Order.create!(client: joao, buffet: buffet, event_type: event1, event_date: 1.day.from_now,
                           estimated_guests: 30, event_details: 'Festa de aniversário',
                           event_address: 'Rua da Praça, 273', status: :pending)
    order2 = Order.create!(client: maria, buffet: buffet, event_type: event2, event_date: 1.day.from_now,
                           estimated_guests: 30, event_details: 'Festa de aniversário',
                           event_address: 'Rua das Flores, 10', status: :canceled)
    order3 = Order.create!(client: joao, buffet: buffet, event_type: event1, event_date: 1.week.from_now,
                           estimated_guests: 30, event_details: 'Festa de aniversário',
                           event_address: 'Rua da Praça, 273', status: :confirmed)

    login_as(owner, scope: :owner)
    visit root_path
    click_on 'Pedidos'

    expect(page).to have_content order1.code
    expect(page).to have_content 'Aguardando Avaliação'
    expect(page).to have_content order2.code
    expect(page).to have_content 'Cancelado'
    expect(page).to have_content order3.code
    expect(page).to have_content 'Confirmado'
  end

  it 'e vê detalhes de um pedido' do
    client = Client.create!(name: 'Joao', personal_code: '94641091064', email: 'joao@email.com', password: '12345678')
    owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
    cash = PaymentMethod.create!(name: 'Dinheiro')
    pix = PaymentMethod.create!(name: 'Pix')
    buffet = Buffet.create!(brand_name: 'Miniland', corporate_name: 'Miniland LTDA',
                            registration_code: '00556164220103', phone_number: '(11)32441110', email: 'miniland@email.com',
                            address: 'Av Martins, 50', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                            postal_code: '14770-070', description: 'Buffet especializado em festas temáticas',
                            owner: owner, payment_methods: [cash, pix])
    event = EventType.create!(name: 'Festa dos Heróis', description: 'Festa infantil com temática de heróis',
                              min_guests: 10, max_guests: 80, duration: 240,
                              menu_details: 'Doces, Salgados, Bebidas',
                              alcohol_option: false, decoration_option: true, parking_service_option: true,
                              location_option: true, buffet: buffet, base_price: 5000.0, extra_guest: 100.0,
                              extra_hour: 500.0, we_base_price: 8000.0, we_extra_guest: 200.0, we_extra_hour: 800.0)
    
    order = Order.create!(client: client, buffet: buffet, event_type: event, event_date: 1.day.from_now,
                          estimated_guests: 30, event_details: 'Festa de aniversário',
                          event_address: 'Rua da Praça, 273', status: :pending)

    login_as owner, scope: :owner
    visit root_path
    click_on 'Pedidos'
    click_on order.code

    expect(current_path).to eq order_path(order)
  end

  it 'e vê notificação quando tem outros pedidos marcados para o mesmo dia' do
    joao = Client.create!(name: 'Joao', personal_code: '94641091064', email: 'joao@email.com', password: '12345678')
    maria = Client.create!(name: 'Maria', personal_code: '95551091000', email: 'maria@email.com', password: '12345678')
    jose = Client.create!(name: 'Jose', personal_code: '96661091011', email: 'jose@email.com', password: '12345678')
    owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
    cash = PaymentMethod.create!(name: 'Dinheiro')
    pix = PaymentMethod.create!(name: 'Pix')
    buffet = Buffet.create!(brand_name: 'Miniland', corporate_name: 'Miniland LTDA',
                            registration_code: '00556164220103', phone_number: '(11)32441110', email: 'miniland@email.com',
                            address: 'Av Martins, 50', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                            postal_code: '14770-070', description: 'Buffet especializado em festas temáticas',
                            owner: owner, payment_methods: [cash, pix])
    event = EventType.create!(name: 'Festa dos Heróis', description: 'Festa infantil com temática de heróis',
                              min_guests: 10, max_guests: 80, duration: 240,
                              menu_details: 'Doces, Salgados, Bebidas',
                              alcohol_option: false, decoration_option: true, parking_service_option: true,
                              location_option: true, buffet: buffet, base_price: 5000.0, extra_guest: 100.0,
                              extra_hour: 500.0, we_base_price: 8000.0, we_extra_guest: 200.0, we_extra_hour: 800.0)
     
    order1 = Order.create!(client: joao, buffet: buffet, event_type: event, event_date: 7.days.from_now,
                           estimated_guests: 30, event_details: 'Festa de aniversário',
                           event_address: 'Rua da Praça, 273', status: :pending)
    order2 = Order.create!(client: maria, buffet: buffet, event_type: event, event_date: 7.days.from_now,
                           estimated_guests: 30, event_details: 'Festa de aniversário',
                           event_address: 'Rua das Flores, 10', status: :pending)
    order3 = Order.create!(client: jose, buffet: buffet, event_type: event, event_date: 7.days.from_now,
                           estimated_guests: 30, event_details: 'Festa de aniversário',
                           event_address: 'Rua das Flores, 53', status: :pending)

    login_as owner, scope: :owner
    visit root_path
    click_on 'Pedidos'
    click_on order1.code

    expect(page).to have_content 'Atenção: Há mais 2 pedidos agendados para o mesmo dia!'
    expect(page).to have_link order2.code
    expect(page).to have_link order3.code
  end

  it 'e notificação aparece apenas para o dono do buffet' do
    joao = Client.create!(name: 'Joao', personal_code: '94641091064', email: 'joao@email.com', password: '12345678')
    maria = Client.create!(name: 'Maria', personal_code: '95551091000', email: 'maria@email.com', password: '12345678')
    owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
    cash = PaymentMethod.create!(name: 'Dinheiro')
    pix = PaymentMethod.create!(name: 'Pix')
    buffet = Buffet.create!(brand_name: 'Miniland', corporate_name: 'Miniland LTDA',
                            registration_code: '00556164220103', phone_number: '(11)32441110', email: 'miniland@email.com',
                            address: 'Av Martins, 50', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                            postal_code: '14770-070', description: 'Buffet especializado em festas temáticas',
                            owner: owner, payment_methods: [cash, pix])
    event = EventType.create!(name: 'Festa dos Heróis', description: 'Festa infantil com temática de heróis',
                              min_guests: 10, max_guests: 80, duration: 240,
                              menu_details: 'Doces, Salgados, Bebidas',
                              alcohol_option: false, decoration_option: true, parking_service_option: true,
                              location_option: true, buffet: buffet, base_price: 5000.0, extra_guest: 100.0,
                              extra_hour: 500.0, we_base_price: 8000.0, we_extra_guest: 200.0, we_extra_hour: 800.0)
     
    order1 = Order.create!(client: joao, buffet: buffet, event_type: event, event_date: 7.days.from_now,
                           estimated_guests: 30, event_details: 'Festa de aniversário',
                           event_address: 'Rua da Praça, 273', status: :pending)
    order2 = Order.create!(client: maria, buffet: buffet, event_type: event, event_date: 7.days.from_now,
                           estimated_guests: 30, event_details: 'Festa de aniversário',
                           event_address: 'Rua das Flores, 10', status: :pending)

    login_as joao, scope: :client
    visit root_path
    click_on 'Meus Pedidos'
    click_on order1.code

    expect(page).not_to have_content 'Atenção: Há mais 1 pedido agendado para o mesmo dia!'
  end

  it 'e não há pedidos para o buffet' do
    owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
    cash = PaymentMethod.create!(name: 'Dinheiro')
    pix = PaymentMethod.create!(name: 'Pix')
    Buffet.create!(brand_name: 'Miniland', corporate_name: 'Miniland LTDA',
                   registration_code: '00556164220103', phone_number: '(11)32441110', email: 'miniland@email.com',
                   address: 'Av Martins, 50', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                   postal_code: '14770-070', description: 'Buffet especializado em festas temáticas',
                   owner: owner, payment_methods: [cash, pix])
    
    login_as owner, scope: :owner
    visit root_path
    click_on 'Pedidos'

    expect(page).to have_content 'Não há pedidos registrados.'
  end

  it 'e retorna para a página inicial' do
    owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
    cash = PaymentMethod.create!(name: 'Dinheiro')
    pix = PaymentMethod.create!(name: 'Pix')
    buffet = Buffet.create!(brand_name: 'Miniland', corporate_name: 'Miniland LTDA',
                            registration_code: '00556164220103', phone_number: '(11)32441110', email: 'miniland@email.com',
                            address: 'Av Martins, 50', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                            postal_code: '14770-070', description: 'Buffet especializado em festas temáticas',
                            owner: owner, payment_methods: [cash, pix])
    
    login_as owner, scope: :owner
    visit root_path
    click_on 'Pedidos'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end
end