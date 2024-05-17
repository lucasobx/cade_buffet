require 'rails_helper'

describe "POST /buffets" do
  it "e não pode cadastrar um segundo buffet" do
    owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
    cash = PaymentMethod.create!(name: 'Dinheiro')
    pix = PaymentMethod.create!(name: 'Pix')
    Buffet.create!(brand_name: 'Casamentos Buffet', corporate_name: 'Casamentos Buffet LTDA',
                   registration_code: '73456164000100', phone_number: '(11)00001111', email: 'casab@email.com',
                   address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                   postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                   owner: owner, payment_methods: [cash, pix])

    login_as owner, scope: :owner

    post buffets_path, params: { buffet: { brand_name: 'Edecy Buffet', corporate_name: 'Edecy Buffet LTDA',
                                           registration_code: '55996244000122', phone_number: '(11)22229988', email: 'edecy@email.com',
                                           address: 'Rua Castilho, 560', neighborhood: 'Piratininga', city: 'Belo Horizonte', state: 'MG',
                                           postal_code: '55280-001', description: 'Buffet para festa infantil',
                                           payment_method_ids: [cash.id, pix.id] } }

    expect(response).to redirect_to(root_path)
    expect(flash[:alert]).to eq 'Você já cadastrou um buffet.'
  end
end