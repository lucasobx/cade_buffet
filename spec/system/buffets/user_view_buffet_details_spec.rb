require 'rails_helper'

describe 'Visitante visita detalhes do buffet' do
  it 'e vê informações adicionais' do
    owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
    cash = PaymentMethod.create!(name: 'Dinheiro')
    pix = PaymentMethod.create!(name: 'Pix')
    Buffet.create!(brand_name: 'Casamentos Buffet', corporate_name: 'Casamentos Buffet LTDA',
                   registration_code: '73456164000100', phone_number: '(11)00001111', email: 'casabuffet@email.com',
                   address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                   postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                   owner: owner, payment_methods: [cash, pix])
    
    visit root_path
    click_on 'Casamentos Buffet'

    expect(page).to have_content 'Casamentos Buffet'
    expect(page).to have_content 'Descrição: Buffet especializado em casamentos'
    expect(page).to have_content 'Contato: (11)00001111 - casabuffet@email.com'
    expect(page).to have_content 'Endereço: Av Machado, 650 - Jardim do Sol, Sales - SP - 14980-970'
    expect(page).to have_content 'Métodos de pagamento aceitos: Dinheiro, Pix'
  end

  it 'e vê os tipos de eventos cadastrados' do
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
    
    visit root_path
    click_on 'Casamentos Buffet'
    expect(page).to have_content 'Festa de Casamento'
    expect(page).to have_content 'Descrição: Espaço luxuoso e confortável'
    expect(page).to have_content 'Capacidade: 15 a 150 convidados'
    expect(page).to have_content 'Duração: 240 minutos'
    expect(page).to have_content 'Cardápio: Doces, Salgados, Bebidas'
    expect(page).to have_content 'Bebidas Alcoólicas: Sim'
    expect(page).to have_content 'Decoração: Sim'
    expect(page).to have_content 'Estacionamento: Sim'
    expect(page).to have_content 'Escolha da Localização: Não'
    expect(page).to have_content 'Preço Base para 15 Convidados: R$10000.0 - Fim de Semana: R$15000.0'
    expect(page).to have_content 'Taxa por Pessoa Excedente: R$250.0 - Fim de Semana: R$400.0'
    expect(page).to have_content 'Taxa por Hora Extra: R$1000.0 - Fim de Semana: R$1500.0'
  end

  it 'e não há tipos de eventos cadastrados' do
    owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
    cash = PaymentMethod.create!(name: 'Dinheiro')
    pix = PaymentMethod.create!(name: 'Pix')
    Buffet.create!(brand_name: 'Casamentos Buffet', corporate_name: 'Casamentos Buffet LTDA',
                   registration_code: '73456164000100', phone_number: '(11)00001111', email: 'casabuffet@email.com',
                   address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                   postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                   owner: owner, payment_methods: [cash, pix])

    visit root_path
    click_on 'Casamentos Buffet'

    expect(page).to have_content 'Não existem eventos cadastrados para este Buffet.'
  end
end