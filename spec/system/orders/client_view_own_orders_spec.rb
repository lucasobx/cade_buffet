require 'rails_helper'

describe 'Cliente vê seus próprios pedidos' do
  it 'e não vê pedidos de outros clientes' do
    joao = Client.create!(name: 'Joao', personal_code: '94641091064', email: 'joao@email.com', password: '12345678')
    maria = Client.create!(name: 'Maria', personal_code: '98661291666', email: 'maria@email.com', password: '12345678')
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
    order1 = Order.create!(client: joao, buffet: buffet, event_type: event, event_date: 1.day.from_now,
                           estimated_guests: 30, event_details: 'Festa de aniversário',
                           event_address: 'Rua da Praça, 273', status: :pending)
    order2 = Order.create!(client: maria, buffet: buffet, event_type: event, event_date: 1.day.from_now,
                           estimated_guests: 30, event_details: 'Festa de aniversário',
                           event_address: 'Rua da Praça, 273', status: :pending)
    order3 = Order.create!(client: joao, buffet: buffet, event_type: event, event_date: 1.week.from_now,
                           estimated_guests: 30, event_details: 'Festa de aniversário',
                           event_address: 'Rua da Praça, 273', status: :confirmed)

    login_as joao, scope: :client
    visit root_path
    click_on 'Meus Pedidos'

    expect(page).to have_content order1.code
    expect(page).to have_content "Data: #{I18n.localize(1.day.from_now.to_date)}"
    expect(page).not_to have_content order2.code
    expect(page).to have_content order3.code
    expect(page).to have_content "Data: #{I18n.localize(1.day.from_now.to_date)}"
  end

  it 'e vê detalhes de um pedido' do
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
    order = Order.create!(client: joao, buffet: buffet, event_type: event, event_date: 1.day.from_now,
                          estimated_guests: 30, event_details: 'Festa de aniversário', event_address: 'Rua da Praça, 273')

    login_as joao, scope: :client
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code

    expect(page).to have_content 'Detalhes do Pedido'
    expect(page).to have_content 'Festa dos Heróis'
    expect(page).to have_content "Data: #{I18n.localize(1.day.from_now.to_date)}"
    expect(page).to have_content 'Endereço: Rua da Praça, 273'
    expect(page).to have_content 'Informações Adicionais: Festa de aniversário'
    expect(page).to have_content 'Status: Aguardando Avaliação'
  end

  it 'e não visita pedidos de outros clientes' do
    joao = Client.create!(name: 'Joao', personal_code: '94641091064', email: 'joao@email.com', password: '12345678')
    maria = Client.create!(name: 'Maria', personal_code: '98661291666', email: 'maria@email.com', password: '12345678')
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
    order = Order.create!(client: joao, buffet: buffet, event_type: event, event_date: 1.day.from_now,
                          estimated_guests: 30, event_details: 'Festa de aniversário', event_address: 'Rua da Praça, 273')
                    
    login_as maria, scope: :client
    visit order_path(order)

    expect(current_path).not_to eq order_path(order)
    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não possui acesso a este pedido.'
  end

  it 'e não há pedidos' do
    joao = Client.create!(name: 'Joao', personal_code: '94641091064', email: 'joao@email.com', password: '12345678')

    login_as joao, scope: :client
    visit root_path
    click_on 'Meus Pedidos'

    expect(page).to have_content 'Você não possui nenhum pedido.'
  end

  it 'e retorna para a página inicial' do
    joao = Client.create!(name: 'Joao', personal_code: '94641091064', email: 'joao@email.com', password: '12345678')

    login_as joao, scope: :client
    visit root_path
    click_on 'Meus Pedidos'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end
end