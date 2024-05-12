# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
owner1 = Owner.create!(name: 'Lucas', email: 'lucas@email.com', password: '12345678')
owner2 = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '87654321')
owner3 = Owner.create!(name: 'Julia', email: 'julia@email.com', password: '14725836')

pix = PaymentMethod.create!(name: 'Pix')
cash = PaymentMethod.create!(name: 'Dinheiro')
credit = PaymentMethod.create!(name: 'Cartão de Crédito')
debit = PaymentMethod.create!(name: 'Cartão de Débito')

buffet1 = Buffet.create!(brand_name: 'Casamentos Buffet', corporate_name: 'Casamentos Buffet LTDA',
                         registration_code: '73456164000100', phone_number: '(11)00001111', email: 'casabuffet@email.com',
                         address: 'Av Machado, 650', neighborhood: 'Butantã', city: 'São Paulo', state: 'SP',
                         postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                         owner: owner1, payment_methods: [cash, pix])
event1 = EventType.create!(name: 'Festa de Casamento', description: 'Espaço luxuoso e confortável',
                           min_guests: 15, max_guests: 150, duration: 240,
                           menu_details: 'Doces, Salgados, Bebidas',
                           alcohol_option: true, decoration_option: true, parking_service_option: true,
                           location_option: false, buffet: buffet1, base_price: 10000.0, extra_guest: 250.0,
                           extra_hour: 1000.0, we_base_price: 15000.0, we_extra_guest: 400.0, we_extra_hour: 1500.0)

buffet2 = Buffet.create!(brand_name: 'Edecy Buffet', corporate_name: 'Edecy Buffet LTDA',
                         registration_code: '55996244000122', phone_number: '(11)22229988', email: 'edecy@email.com',
                         address: 'Rua Castilho, 560', neighborhood: 'Piratininga', city: 'Belo Horizonte', state: 'MG',
                         postal_code: '55280-001', description: 'Buffet para festa infantil',
                         owner: owner2, payment_methods: [credit, debit])
event2 = EventType.create!(name: 'Piscina de Bolinhas', description: 'Festa infantil com fantasias',
                           min_guests: 10, max_guests: 50, duration: 120,
                           menu_details: 'Doces, Salgados',
                           alcohol_option: false, decoration_option: true, parking_service_option: true,
                           location_option: true, buffet: buffet2, base_price: 5000.0, extra_guest: 100.0,
                           extra_hour: 500.0, we_base_price: 8000.0, we_extra_guest: 200.0, we_extra_hour: 800.0)

buffet3 = Buffet.create!(brand_name: 'La Luna Casamentos', corporate_name: 'La Luna Casamentos LTDA',
                         registration_code: '63001164000100', phone_number: '(11)22223333', email: 'laluna@email.com',
                         address: 'Av Pinheiros, 50', neighborhood: 'Pinheiros', city: 'São Paulo', state: 'SP',
                         postal_code: '05080-001', description: 'Buffet especializado em casamentos',
                         owner: owner3, payment_methods: [credit, debit]) 
event3 = EventType.create!(name: 'Festa de Casamento', description: 'Local espaçoso, versátil e confortável',
                           min_guests: 10, max_guests: 50, duration: 120,
                           menu_details: 'Bolo, Doces, Salgados e Bebidas',
                           alcohol_option: true, decoration_option: true, parking_service_option: true,
                           location_option: true, buffet: buffet3, base_price: 5000.0, extra_guest: 100.0,
                           extra_hour: 500.0, we_base_price: 8000.0, we_extra_guest: 200.0, we_extra_hour: 800.0)

client1 = Client.create!(name: 'Julia', personal_code: '47406693079', email: 'julia@email.com', password: '12345678')
client2 = Client.create!(name: 'Bruna', personal_code: '37307794571', email: 'bruna@email.com', password: '12345678')
client3 = Client.create!(name: 'Joao', personal_code: '35008815522', email: 'joao@email.com', password: '12345678')

order1 = Order.create!(client: client1, buffet: buffet1, event_type: event1, event_date: 7.days.from_now,
                       estimated_guests: 30, event_details: 'Minha festa de casamento')
order2 = Order.create!(client: client2, buffet: buffet1, event_type: event1, event_date: 7.days.from_now,
                       estimated_guests: 30, event_details: 'Festa de casamento dos meus filhos')
order3 = Order.create!(client: client3, buffet: buffet1, event_type: event1, event_date: 7.days.from_now,
                       estimated_guests: 30, event_details: 'Festa de casamento dos meus pais')                       