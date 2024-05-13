require 'rails_helper'

describe 'Dono de Buffet informa novo status de pedido' do
  it 'e pedido foi cancelado' do
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
    click_on 'Cancelar Pedido'

    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Status: Cancelado'
  end
end