require 'rails_helper'

describe 'EventType API' do
  context 'GET /api/v1/buffets/:buffet_id/event_types' do
    it 'lista todos os tipos de eventos de um buffet' do
      owner = Owner.create!(name: 'Bianca', email: 'bianca@email.com', password: '12345678')
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
      EventType.create!(name: 'Casamento na Praia', description: 'Festa de casamento na praia',
                        min_guests: 15, max_guests: 50, duration: 240,
                        menu_details: 'Doces, Salgados, Bebidas',
                        alcohol_option: true, decoration_option: false, parking_service_option: true,
                        location_option: false, buffet: buffet, base_price: 20000.0, extra_guest: 350.0,
                        extra_hour: 2000.0, we_base_price: 25000.0, we_extra_guest: 500.0, we_extra_hour: 2500.0)

      get "/api/v1/buffets/#{buffet.id}/event_types"

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 2
      expect(json_response[0]["name"]).to eq 'Casamento na Praia'
      expect(json_response[1]["name"]).to eq 'Festa de Casamento'
    end

    it 'e falha se nenhum tipo de evento é encontrado' do
      owner = Owner.create!(name: 'Bianca', email: 'bianca@email.com', password: '12345678')
      cash = PaymentMethod.create!(name: 'Dinheiro')
      pix = PaymentMethod.create!(name: 'Pix')
      buffet = Buffet.create!(brand_name: 'Casamentos Buffet', corporate_name: 'Casamentos Buffet LTDA',
                              registration_code: '73456164000100', phone_number: '(11)00001111', email: 'casabuffet@email.com',
                              address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                              postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                              owner: owner, payment_methods: [cash, pix])

      get "/api/v1/buffets/#{buffet.id}/event_types"

      expect(response.status).to eq 404
    end
  end

  context 'GET /api/v1/event_types/:id' do
    it 'consulta a disponibilidade com sucesso' do
      owner = Owner.create!(name: 'Bianca', email: 'bianca@email.com', password: '12345678')
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
      
      get "/api/v1/event_types/#{event.id}", params: { event_date: next_weekday_from_today, guest_number: "30" }

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response["id"]).to eq event.id
      expect(json_response["estimated_price"]).to eq "13750.0"
    end

    it 'falha se a data não é futura' do
      owner = Owner.create!(name: 'Bianca', email: 'bianca@email.com', password: '12345678')
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
      
      get "/api/v1/event_types/#{event.id}", params: { event_date: "23-05-03", guest_number: "30" }

      expect(response.status).to eq 400
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response["error"]).to eq 'A data deve ser futura'
    end

    it 'falha se a data está indisponível' do
      client = Client.create!(name: 'Julia', personal_code: '47406693079', email: 'julia@email.com', password: '12345678')
      owner = Owner.create!(name: 'Bianca', email: 'bianca@email.com', password: '12345678')
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
      Order.create!(client: client, buffet: buffet, event_type: event, event_date: next_weekday_from_today,
                    estimated_guests: 30, event_details: 'Festa de aniversário', event_address: 'Rua da Praça, 273',
                    status: :pending)
      
      get "/api/v1/event_types/#{event.id}", params: { event_date: next_weekday_from_today, guest_number: "30" }

      expect(response.status).to eq 409
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response["error"]).to eq 'Data indisponível para este evento'
    end

    it 'falha se a quantidade de convidados excede o limite' do
      owner = Owner.create!(name: 'Bianca', email: 'bianca@email.com', password: '12345678')
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

      get "/api/v1/event_types/#{event.id}", params: { event_date: next_weekday_from_today, guest_number: "200" }               

      expect(response.status).to eq 409
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response["error"]).to eq 'Quantidade de convidados excede o limite para este evento'
    end
  end  
end