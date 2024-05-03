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
end