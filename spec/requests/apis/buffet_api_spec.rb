require 'rails_helper'

describe 'Buffet API' do
  context 'GET /api/v1/buffets/:id' do
    it 'com sucesso' do
      owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
      cash = PaymentMethod.create!(name: 'Dinheiro')
      pix = PaymentMethod.create!(name: 'Pix')
      buffet = Buffet.create!(brand_name: 'Casamentos Buffet', corporate_name: 'Casamentos Buffet LTDA',
                              registration_code: '73456164000100', phone_number: '(11)00001111', email: 'casabuffet@email.com',
                              address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                              postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                              owner: owner, payment_methods: [cash, pix])

      get "/api/v1/buffets/#{buffet.id}"

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'

      json_response = JSON.parse(response.body)
      
      expect(json_response["brand_name"]).to eq 'Casamentos Buffet'
      expect(json_response["phone_number"]).to eq '(11)00001111'
      expect(json_response["email"]).to eq 'casabuffet@email.com'
      expect(json_response["address"]).to eq 'Av Machado, 650'
      expect(json_response["neighborhood"]).to eq 'Jardim do Sol'
      expect(json_response["city"]).to eq 'Sales'
      expect(json_response["state"]).to eq 'SP'
      expect(json_response["postal_code"]).to eq '14980-970'
      expect(json_response["description"]).to eq 'Buffet especializado em casamentos'
      expect(json_response["payment_methods"].length).to eq 2
      expect(json_response["payment_methods"].first['name']).to eq 'Dinheiro'
      expect(json_response["payment_methods"].last['name']).to eq 'Pix'

      expect(json_response.keys).not_to include 'corporate_name'
      expect(json_response.keys).not_to include 'registration_code'
    end

    it 'e falha se buffet não é encontrado' do
      get "/api/v1/buffets/9999999"

      expect(response.status).to eq 404
    end
  end

  context 'GET /api/v1/buffets' do
    it 'lista todos os buffets ordenados pelo nome' do
      owner1 = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
      owner2 = Owner.create!(name: 'Maria', email: 'maria@email.com', password: '12345678')
      owner3 = Owner.create!(name: 'Joao', email: 'joao@email.com', password: '12345678')
      cash = PaymentMethod.create!(name: 'Dinheiro')
      pix = PaymentMethod.create!(name: 'Pix')
      Buffet.create!(brand_name: 'Casamentos Buffet', corporate_name: 'Casamentos Buffet LTDA',
                     registration_code: '73456164000100', phone_number: '(11)00001111', email: 'casabuffet@email.com',
                     address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                     postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                     owner: owner1, payment_methods: [cash, pix])
      Buffet.create!(brand_name: 'Amanita Buffet', corporate_name: 'Amanita Buffet LTDA',
                     registration_code: '78856164222133', phone_number: '(11)00001111', email: 'casabuffet@email.com',
                     address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                     postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                     owner: owner2, payment_methods: [cash, pix])
      Buffet.create!(brand_name: 'Miniland', corporate_name: 'Miniland LTDA',
                     registration_code: '00556164220103', phone_number: '(11)32441110', email: 'miniland@email.com',
                     address: 'Av Martins, 50', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                     postal_code: '14770-070', description: 'Buffet especializado em festas temáticas',
                     owner: owner3, payment_methods: [cash, pix])

      get '/api/v1/buffets'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 3
      expect(json_response[0]["brand_name"]).to eq 'Amanita Buffet'
      expect(json_response[1]["brand_name"]).to eq 'Casamentos Buffet'
      expect(json_response[2]["brand_name"]).to eq 'Miniland'
    end

    it 'e retorna vazio se não tem nenhum buffet' do
      get '/api/v1/buffets'

      expect(response.status).to  eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response).to eq []
    end

    it 'e busca um buffet informando um texto' do
      owner1 = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
      owner2 = Owner.create!(name: 'Maria', email: 'maria@email.com', password: '12345678')
      owner3 = Owner.create!(name: 'Joao', email: 'joao@email.com', password: '12345678')
      cash = PaymentMethod.create!(name: 'Dinheiro')
      pix = PaymentMethod.create!(name: 'Pix')
      Buffet.create!(brand_name: 'Casamentos Buffet', corporate_name: 'Casamentos Buffet LTDA',
                     registration_code: '73456164000100', phone_number: '(11)00001111', email: 'casabuffet@email.com',
                     address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                     postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                     owner: owner1, payment_methods: [cash, pix])
      Buffet.create!(brand_name: 'Amanita Buffet', corporate_name: 'Amanita Buffet LTDA',
                     registration_code: '78856164222133', phone_number: '(11)00001111', email: 'casabuffet@email.com',
                     address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                     postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                     owner: owner2, payment_methods: [cash, pix])
      Buffet.create!(brand_name: 'Miniland', corporate_name: 'Miniland LTDA',
                     registration_code: '00556164220103', phone_number: '(11)32441110', email: 'miniland@email.com',
                     address: 'Av Silva, 50', neighborhood: 'Butantã', city: 'São Paulo', state: 'SP',
                     postal_code: '14770-070', description: 'Buffet especializado em festas temáticas',
                     owner: owner3, payment_methods: [cash, pix])

      get '/api/v1/buffets', params: { search: 'miniland' }

      expect(response.status).to eq 200
      expect(response.content_type).to include "application/json"
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 1
      expect(json_response.last["brand_name"]).to eq "Miniland"
    end

    it 'e gera erro interno' do
      allow(Buffet).to receive(:all).and_raise(ActiveRecord::QueryCanceled)

      get '/api/v1/buffets'

      expect(response).to have_http_status(500)
    end
  end
end