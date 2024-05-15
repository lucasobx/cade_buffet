require 'rails_helper'

describe 'Dono de Buffet informa novo status de pedido' do
  it 'e pedido é aprovado a partir dos detalhes do pedido' do
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
    
    within '#order_details' do
      expect(page).to have_content "Valor Provisório: R$#{order.final_price}"
    end
    within '#evaluate_order' do
      expect(page).to have_content 'Avaliar Pedido'
      expect(page).to have_content "Valor Final: R$#{order.final_price}"
      expect(page).to have_field 'Data-Limite'
      expect(page).to have_field 'Taxa Extra'
      expect(page).to have_field 'Desconto'
      expect(page).to have_field 'Detalhes do Ajuste'
      expect(page).to have_content 'Método de Pagamento'
      expect(page).to have_button 'Aprovar Pedido'
    end
  end

  it 'com sucesso' do
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
    order = Order.create!(client: client, buffet: buffet, event_type: event, event_date: next_weekend_from_today,
                          estimated_guests: 30, event_details: 'Festa de aniversário',
                          event_address: 'Rua da Praça, 273', status: :pending)

    login_as owner, scope: :owner
    visit root_path
    click_on 'Pedidos'
    click_on order.code
    fill_in 'Data-Limite', with: 2.weeks.from_now
    fill_in 'Taxa Extra', with: '200'
    fill_in 'Desconto', with: '20'
    fill_in 'Detalhes do Ajuste', with: 'R$200,00 para o deslocamento. Desconto de R$20,00 pelo primeiro pedido'
    select 'Pix', from: 'Método de Pagamento'
    click_on 'Aprovar Pedido'

    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Pedido aprovado com sucesso!'
    expect(page).to have_content "Valor Final: R$12180.0"
    expect(page).to have_content "Data-Limite: #{order.price_valid_until}"
    expect(page).to have_content 'Taxa Extra: R$200.0'
    expect(page).to have_content 'Desconto: R$20.0'
    expect(page).to have_content 'Detalhes do Ajuste: R$200,00 para o deslocamento. Desconto de R$20,00 pelo primeiro pedido'
    expect(page).to have_content 'Método de Pagamento: Pix'
    expect(page).to have_content 'Status: Aprovado'
    expect(page).not_to have_button 'Aprovar Pedido'
    expect(page).not_to have_button 'Cancelar Pedido'
  end

  it 'e pedido é cancelado' do
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
    expect(page).not_to have_button 'Aprovar Pedido'
    expect(page).not_to have_button 'Cancelar Pedido'
  end
end