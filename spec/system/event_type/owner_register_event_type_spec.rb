require 'rails_helper'

describe 'Proprietário cadastra tipo de evento' do
  it 'a partir dos detalhes do buffet' do
    owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
    cash = PaymentMethod.create!(name: 'Dinheiro')
    pix = PaymentMethod.create!(name: 'Pix')
    buffet = Buffet.create!(
      brand_name: 'Casamentos Buffet',
      corporate_name: 'Casamentos Buffet LTDA',
      registration_code: '73456164000100',
      phone_number: '(11)00001111',
      email: 'casabuffet@email.com',
      address: 'Av Machado, 650',
      neighborhood: 'Jardim do Sol',
      city: 'Sales',
      state: 'SP',
      postal_code: '14980-970',
      description: 'Buffet especializado em casamentos',
      owner: owner,
      payment_methods: [cash, pix])

    login_as(owner)
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
    expect(page).to have_content 'Local'
  end

  it 'com sucesso' do
    owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
    cash = PaymentMethod.create!(name: 'Dinheiro')
    pix = PaymentMethod.create!(name: 'Pix')
    buffet = Buffet.create!(
      brand_name: 'Casamentos Buffet',
      corporate_name: 'Casamentos Buffet LTDA',
      registration_code: '73456164000100',
      phone_number: '(11)00001111',
      email: 'casabuffet@email.com',
      address: 'Av Machado, 650',
      neighborhood: 'Jardim do Sol',
      city: 'Sales',
      state: 'SP',
      postal_code: '14980-970',
      description: 'Buffet especializado em casamentos',
      owner: owner,
      payment_methods: [cash, pix])

    login_as(owner)
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
  end

  it 'e deve preencher todos os campos' do
    owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
    cash = PaymentMethod.create!(name: 'Dinheiro')
    pix = PaymentMethod.create!(name: 'Pix')
    buffet = Buffet.create!(
      brand_name: 'Casamentos Buffet',
      corporate_name: 'Casamentos Buffet LTDA',
      registration_code: '73456164000100',
      phone_number: '(11)00001111',
      email: 'casabuffet@email.com',
      address: 'Av Machado, 650',
      neighborhood: 'Jardim do Sol',
      city: 'Sales',
      state: 'SP',
      postal_code: '14980-970',
      description: 'Buffet especializado em casamentos',
      owner: owner,
      payment_methods: [cash, pix])

    login_as(owner)
    visit root_path
    within 'nav' do
      click_on 'Meu Buffet'
    end
    click_on 'Cadastrar Tipo de Evento'
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    click_on 'Enviar'

    expect(page).to have_content 'Não foi possível cadastrar o tipo de evento.'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Descrição não pode ficar em branco'
  end
end