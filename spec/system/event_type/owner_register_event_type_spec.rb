require 'rails_helper'

describe 'Dono de Buffet cadastra tipo de evento' do
  it 'e deve estar autenticado' do
    owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
    cash = PaymentMethod.create!(name: 'Dinheiro')
    pix = PaymentMethod.create!(name: 'Pix')
    buffet = Buffet.create!(brand_name: 'Casamentos Buffet', corporate_name: 'Casamentos Buffet LTDA',
                            registration_code: '73456164000100', phone_number: '(11)00001111', email: 'casabuffet@email.com',
                            address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                            postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                            owner: owner, payment_methods: [cash, pix])
        
    visit new_buffet_event_type_path(buffet.id)

    expect(current_path).to eq new_owner_session_path
  end

  it 'a partir dos detalhes do buffet' do
    owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
    cash = PaymentMethod.create!(name: 'Dinheiro')
    pix = PaymentMethod.create!(name: 'Pix')
    buffet = Buffet.create!(brand_name: 'Casamentos Buffet', corporate_name: 'Casamentos Buffet LTDA',
                            registration_code: '73456164000100', phone_number: '(11)00001111', email: 'casabuffet@email.com',
                            address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                            postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                            owner: owner, payment_methods: [cash, pix])

    login_as owner, scope: :owner
    visit root_path
    within 'nav' do
      click_on 'Meu Buffet'
    end
    click_on 'Cadastrar Tipo de Evento'

    expect(current_path).to eq new_buffet_event_type_path(buffet.id)
    expect(page).to have_content'Novo Tipo de Evento'
    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Descrição'
    expect(page).to have_field 'Mínimo de Convidados'
    expect(page).to have_field 'Máximo de Convidados'
    expect(page).to have_field 'Duração'
    expect(page).to have_field 'Cardápio'
    expect(page).to have_content 'Bebidas Alcoólicas'
    expect(page).to have_content 'Decoração'
    expect(page).to have_content 'Estacionamento'
    expect(page).to have_content 'Preço Base'
    expect(page).to have_content 'Taxa por Pessoa Excedente'
    expect(page).to have_content 'Taxa por Hora Extra'
    expect(page).to have_content 'Preço no Fim de Semana'
    expect(page).to have_content 'Taxa por Pessoa Excedente no Fim de Semana'
    expect(page).to have_content 'Taxa por Hora Extra no Fim de Semana'
    expect(page).to have_content 'Local'
  end

  it 'com sucesso' do
    owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
    cash = PaymentMethod.create!(name: 'Dinheiro')
    pix = PaymentMethod.create!(name: 'Pix')
    Buffet.create!(brand_name: 'Casamentos Buffet', corporate_name: 'Casamentos Buffet LTDA',
                   registration_code: '73456164000100', phone_number: '(11)00001111', email: 'casabuffet@email.com',
                   address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                   postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                   owner: owner, payment_methods: [cash, pix])

    login_as owner, scope: :owner
    visit root_path
    within 'nav' do
      click_on 'Meu Buffet'
    end
    click_on 'Cadastrar Tipo de Evento'
    fill_in 'Nome', with: 'Festa de Casamento'
    fill_in 'Descrição', with: 'Espaço luxuoso e confortável'
    fill_in 'Mínimo de Convidados', with: '15'
    fill_in 'Máximo de Convidados', with: '150'
    fill_in 'Duração', with: '240'
    fill_in 'Cardápio', with: 'Bolo, Salgados, Doces, Bebidas'
    check 'Bebidas Alcoólicas'
    check 'Decoração'
    check 'Estacionamento'
    fill_in 'Preço Base', with: '10000'
    fill_in 'Taxa por Pessoa Excedente', with: '250'
    fill_in 'Taxa por Hora Extra', with: '1000'
    fill_in 'Preço no Fim de Semana', with: '15000'
    fill_in 'Taxa por Pessoa Excedente no Fim de Semana', with: '400'
    fill_in 'Taxa por Hora Extra no Fim de Semana', with: '1500'
    click_on 'Enviar'

    expect(page).to have_content 'Tipo de Evento cadastrado com sucesso.'
    expect(page).to have_content 'Festa de Casamento'
    expect(page).to have_content 'Descrição: Espaço luxuoso e confortável'
    expect(page).to have_content 'Capacidade: 15 a 150 convidados'
    expect(page).to have_content 'Duração: 240 minutos'
    expect(page).to have_content 'Cardápio: Bolo, Salgados, Doces, Bebidas'
    expect(page).to have_content 'Bebidas Alcoólicas: Sim'
    expect(page).to have_content 'Decoração: Sim'
    expect(page).to have_content 'Estacionamento: Sim'
    expect(page).to have_content 'Escolha da Localização: Não'
    expect(page).to have_content 'Preço Base para 15 Convidados: R$10000.0 - Fim de Semana: R$15000.0'
    expect(page).to have_content 'Taxa por Pessoa Excedente: R$250.0 - Fim de Semana: R$400.0'
    expect(page).to have_content 'Taxa por Hora Extra: R$1000.0 - Fim de Semana: R$1500.0'
  end

  it 'e deve preencher todos os campos' do
    owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
    cash = PaymentMethod.create!(name: 'Dinheiro')
    pix = PaymentMethod.create!(name: 'Pix')
    Buffet.create!(brand_name: 'Casamentos Buffet', corporate_name: 'Casamentos Buffet LTDA',
                   registration_code: '73456164000100', phone_number: '(11)00001111', email: 'casabuffet@email.com',
                   address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                   postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                   owner: owner, payment_methods: [cash, pix])

    login_as owner, scope: :owner
    visit root_path
    within 'nav' do
      click_on 'Meu Buffet'
    end
    click_on 'Cadastrar Tipo de Evento'
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Preço Base', with: ''
    click_on 'Enviar'

    expect(page).to have_content 'Não foi possível cadastrar o tipo de evento.'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Descrição não pode ficar em branco'
    expect(page).to have_content 'Preço Base não pode ficar em branco'
  end
end