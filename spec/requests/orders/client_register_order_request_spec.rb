require 'rails_helper'

describe 'POST /orders' do
  it 'e já possui um pedido pendente' do
    joao = Client.create!(name: 'Joao', personal_code: '94441092264', email: 'joao@email.com', password: '12345678')
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
                  estimated_guests: 30, event_details: 'Festa de aniversário',
                  event_address: 'Rua da Praça, 273', status: :pending)

    login_as joao, scope: :client
    post orders_path, params: { order: { buffet_id: buffet.id, event_date: 1.week.from_now, estimated_guests: 20,
                                         event_details: 'Festa de aniversário', event_address: 'Rua da Praça, 273' },
                                         event_type_id: event.id }

    expect(response).to redirect_to buffet_path(buffet)
    expect(flash[:alert]).to eq 'Já existe um pedido pendente para este buffet.'
  end
end