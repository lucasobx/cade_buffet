# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
f_owner = Owner.create!(name: 'Lucas', email: 'lucas@email.com', password: '12345678')
s_owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '87654321')
t_owner = Owner.create!(name: 'Julia', email: 'julia@email.com', password: '14725836')
client = Client.create!(name: 'Julia', personal_code: '47406693079', email: 'julia@email.com', password: '12345678')

pix = PaymentMethod.create!(name: 'Pix')
cash = PaymentMethod.create!(name: 'Dinheiro')
credit = PaymentMethod.create!(name: 'Cartão de Crédito')
debit = PaymentMethod.create!(name: 'Cartão de Débito')

f_buffet = Buffet.create!(
  brand_name: 'Casamentos Buffet',
  corporate_name: 'Casamentos Buffet LTDA',
  registration_code: '73456164000100',
  phone_number: '(11)00001111',
  email: 'casabuffet@email.com',
  address: 'Av Machado, 650',
  neighborhood: 'Butantã',
  city: 'São Paulo',
  state: 'SP',
  postal_code: '14980-970',
  description: 'Buffet especializado em casamentos',
  owner: f_owner,
  payment_methods: [cash, pix])

EventType.create!(
  name: 'Festa de Casamento',
  description: 'Espaço luxuoso e confortável',
  min_guests: 15,
  max_guests: 150,
  duration: 240,
  menu_details: 'Doces, Salgados, Bebidas',
  alcohol_option: true,
  decoration_option: true,
  parking_service_option: true,
  location_option: false,
  buffet: f_buffet,
  base_price: 10000.0,
  extra_guest: 250.0,
  extra_hour: 1000.0,
  we_base_price: 15000.0,
  we_extra_guest: 400.0,
  we_extra_hour: 1500.0)

s_buffet = Buffet.create!(
  brand_name: 'Edecy Buffet',
  corporate_name: 'Edecy Buffet LTDA',
  registration_code: '55996244000122',
  phone_number: '(11)22229988',
  email: 'edecy@email.com',
  address: 'Rua Castilho, 560',
  neighborhood: 'Piratininga',
  city: 'Belo Horizonte',
  state: 'MG',
  postal_code: '55280-001',
  description: 'Buffet para festa infantil',
  owner: s_owner,
  payment_methods: [credit, debit])

EventType.create!(
  name: 'Piscina de Bolinhas',
  description: 'Festa infantil com fantasias',
  min_guests: 10,
  max_guests: 50,
  duration: 120,
  menu_details: 'Doces, Salgados',
  alcohol_option: false,
  decoration_option: true,
  parking_service_option: true,
  location_option: true,
  buffet: s_buffet,
  base_price: 5000.0,
  extra_guest: 100.0,
  extra_hour: 500.0,
  we_base_price: 8000.0,
  we_extra_guest: 200.0,
  we_extra_hour: 800.0)

t_buffet = Buffet.create!(
  brand_name: 'La Luna Casamentos',
  corporate_name: 'La Luna Casamentos LTDA',
  registration_code: '63001164000100',
  phone_number: '(11)22223333',
  email: 'laluna@email.com',
  address: 'Av Pinheiros, 50',
  neighborhood: 'Pinheiros',
  city: 'São Paulo',
  state: 'SP',
  postal_code: '05080-001',
  description: 'Buffet especializado em casamentos',
  owner: t_owner,
  payment_methods: [credit, debit])
  
EventType.create!(
  name: 'Festa de Casamento',
  description: 'Local espaçoso, versátil e confortável',
  min_guests: 10,
  max_guests: 50,
  duration: 120,
  menu_details: 'Bolo, Doces, Salgados e Bebidas',
  alcohol_option: true,
  decoration_option: true,
  parking_service_option: true,
  location_option: true,
  buffet: t_buffet,
  base_price: 5000.0,
  extra_guest: 100.0,
  extra_hour: 500.0,
  we_base_price: 8000.0,
  we_extra_guest: 200.0,
  we_extra_hour: 800.0)