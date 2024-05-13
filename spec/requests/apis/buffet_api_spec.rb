require 'rails_helper'

describe 'Buffet API' do
  context 'GET /api/v1/buffets/1' do
    it 'success' do
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
      
      expect(json_response["brand_name"]).to eq buffet.brand_name
    end
  end
end