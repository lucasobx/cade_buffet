require 'rails_helper'

describe 'dono de buffet edita tipo de evento' do
  it 'e deve estar autenticado' do
    owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
    cash = PaymentMethod.create!(name: 'Dinheiro')
    pix = PaymentMethod.create!(name: 'Pix')
    buffet = Buffet.create!(brand_name: 'Casamentos Buffet', corporate_name: 'Casamentos Buffet LTDA',
                            registration_code: '73456164000100', phone_number: '(11)00001111', email: 'casabuffet@email.com',
                            address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                            postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                            owner: owner, payment_methods: [cash, pix])
    event = EventType.create!(name: 'Festa de Casamento', description: 'Espaço luxuoso e confortável',
                              min_guests: 15, max_guests: 150, duration: 240,
                              menu_details: 'Doces, Salgados, Bebidas',
                              alcohol_option: true, decoration_option: true, parking_service_option: true,
                              location_option: false, buffet: buffet, base_price: 10000.0, extra_guest: 250.0,
                              extra_hour: 1000.0, we_base_price: 15000.0, we_extra_guest: 400.0, we_extra_hour: 1500.0)
    
    visit edit_event_type_path(event)

    expect(current_path).to eq new_owner_session_path
  end

  it 'a partir dos detalhes do evento' do
    owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
    cash = PaymentMethod.create!(name: 'Dinheiro')
    pix = PaymentMethod.create!(name: 'Pix')
    buffet = Buffet.create!(brand_name: 'Casamentos Buffet', corporate_name: 'Casamentos Buffet LTDA',
                            registration_code: '73456164000100', phone_number: '(11)00001111', email: 'casabuffet@email.com',
                            address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                            postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                            owner: owner, payment_methods: [cash, pix])
    EventType.create!(name: 'Festa de Casamento', description: 'Espaço luxuoso e confortável',
                      min_guests: 15, max_guests: 150, duration: 240,
                      menu_details: 'Doces, Salgados, Bebidas',
                      alcohol_option: true, decoration_option: true, parking_service_option: true,
                      location_option: false, buffet: buffet, base_price: 10000.0, extra_guest: 250.0,
                      extra_hour: 1000.0, we_base_price: 15000.0, we_extra_guest: 400.0, we_extra_hour: 1500.0)

    login_as owner, scope: :owner
    visit root_path
    within 'nav' do
      click_on 'Meu Buffet'
    end
    click_on 'Editar Festa de Casamento'

    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Descrição'
    expect(page).to have_field 'Mínimo de Convidados'
    expect(page).to have_field 'Máximo de Convidados'
    expect(page).to have_field 'Duração'
    expect(page).to have_field 'Cardápio'
    expect(page).to have_content 'Bebidas Alcoólicas'
    expect(page).to have_content 'Decoração'
    expect(page).to have_content 'Estacionamento'
    expect(page).to have_content 'Local'
  end

  it 'com sucesso' do
    owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
    cash = PaymentMethod.create!(name: 'Dinheiro')
    pix = PaymentMethod.create!(name: 'Pix')
    buffet = Buffet.create!(brand_name: 'Casamentos Buffet', corporate_name: 'Casamentos Buffet LTDA',
                            registration_code: '73456164000100', phone_number: '(11)00001111', email: 'casabuffet@email.com',
                            address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                            postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                            owner: owner, payment_methods: [cash, pix])
    EventType.create!(name: 'Festa de Casamento', description: 'Espaço luxuoso e confortável',
                      min_guests: 15, max_guests: 150, duration: 240,
                      menu_details: 'Doces, Salgados, Bebidas',
                      alcohol_option: true, decoration_option: true, parking_service_option: true,
                      location_option: false, buffet: buffet, base_price: 10000.0, extra_guest: 250.0,
                      extra_hour: 1000.0, we_base_price: 15000.0, we_extra_guest: 400.0, we_extra_hour: 1500.0)

    login_as owner, scope: :owner
    visit root_path
    within 'nav' do
      click_on 'Meu Buffet'
    end
    click_on 'Editar Festa de Casamento'
    fill_in 'Mínimo de Convidados', with: '30'
    fill_in 'Máximo de Convidados', with: '250'
    fill_in 'Preço Base', with: '8000'
    click_on 'Enviar'

    expect(page).to have_content 'Tipo de Evento atualizado com sucesso.'
    expect(page).to have_content 'Capacidade: 30 a 250 convidados'
    expect(page).to have_content 'Preço Base para 30 Convidados: R$8000.0'
  end

  it 'e faz upload de imagens' do
    owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
    cash = PaymentMethod.create!(name: 'Dinheiro')
    pix = PaymentMethod.create!(name: 'Pix')
    buffet = Buffet.create!(brand_name: 'Casamentos Buffet', corporate_name: 'Casamentos Buffet LTDA',
                            registration_code: '73456164000100', phone_number: '(11)00001111', email: 'casabuffet@email.com',
                            address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                            postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                            owner: owner, payment_methods: [cash, pix])
    EventType.create!(name: 'Festa de Casamento', description: 'Espaço luxuoso e confortável',
                      min_guests: 15, max_guests: 150, duration: 240,
                      menu_details: 'Doces, Salgados, Bebidas',
                      alcohol_option: true, decoration_option: true, parking_service_option: true,
                      location_option: false, buffet: buffet, base_price: 10000.0, extra_guest: 250.0,
                      extra_hour: 1000.0, we_base_price: 15000.0, we_extra_guest: 400.0, we_extra_hour: 1500.0)

    login_as owner, scope: :owner
    visit root_path
    within 'nav' do
      click_on 'Meu Buffet'
    end
    click_on 'Editar Festa de Casamento'
    attach_file 'Fotos', [Rails.root.join('spec', 'files', 'evento1.jpg'), Rails.root.join('spec', 'files', 'evento2.jpg')]
    click_on 'Enviar'

    expect(page).to have_css('img[src*="evento1.jpg"]')
    expect(page).to have_css('img[src*="evento2.jpg"]')
  end

  it 'e deve preencher todos os campos' do
    owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
    cash = PaymentMethod.create!(name: 'Dinheiro')
    pix = PaymentMethod.create!(name: 'Pix')
    buffet = Buffet.create!(brand_name: 'Casamentos Buffet', corporate_name: 'Casamentos Buffet LTDA',
                            registration_code: '73456164000100', phone_number: '(11)00001111', email: 'casabuffet@email.com',
                            address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                            postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                            owner: owner, payment_methods: [cash, pix])
    EventType.create!(name: 'Festa de Casamento', description: 'Espaço luxuoso e confortável',
                      min_guests: 15, max_guests: 150, duration: 240,
                      menu_details: 'Doces, Salgados, Bebidas',
                      alcohol_option: true, decoration_option: true, parking_service_option: true,
                      location_option: false, buffet: buffet, base_price: 10000.0, extra_guest: 250.0,
                      extra_hour: 1000.0, we_base_price: 15000.0, we_extra_guest: 400.0, we_extra_hour: 1500.0)

    login_as owner, scope: :owner
    visit root_path
    within 'nav' do
      click_on 'Meu Buffet'
    end
    click_on 'Editar Festa de Casamento'
    fill_in 'Nome', with: ''
    fill_in 'Cardápio', with: ''
    click_on 'Enviar'
    
    expect(page).to have_content 'Não foi possível atualizar o tipo de evento.'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Cardápio não pode ficar em branco'
  end

  it 'e retorna para os detalhes do buffet' do
    owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
    cash = PaymentMethod.create!(name: 'Dinheiro')
    pix = PaymentMethod.create!(name: 'Pix')
    buffet = Buffet.create!(brand_name: 'Casamentos Buffet', corporate_name: 'Casamentos Buffet LTDA',
                            registration_code: '73456164000100', phone_number: '(11)00001111', email: 'casabuffet@email.com',
                            address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                            postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                            owner: owner, payment_methods: [cash, pix])
    buffet = EventType.create!(name: 'Festa de Casamento', description: 'Espaço luxuoso e confortável',
                               min_guests: 15, max_guests: 150, duration: 240,
                               menu_details: 'Doces, Salgados, Bebidas',
                               alcohol_option: true, decoration_option: true, parking_service_option: true,
                               location_option: false, buffet: buffet, base_price: 10000.0, extra_guest: 250.0,
                               extra_hour: 1000.0, we_base_price: 15000.0, we_extra_guest: 400.0, we_extra_hour: 1500.0)

    login_as owner, scope: :owner
    visit root_path
    click_on 'Meu Buffet'
    click_on 'Editar Festa de Casamento'
    click_on 'Voltar'

    expect(current_path).to eq buffet_path(buffet)
  end
end