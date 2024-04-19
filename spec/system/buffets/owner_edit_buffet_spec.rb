require 'rails_helper'

describe 'Proprietário edita um buffet' do
  it 'a partir da página de detalhes' do
    owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
    Buffet.create!(
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
      owner: owner)
    
    login_as(owner)
    visit root_path
    click_on 'Casamentos Buffet'
    click_on 'Editar'

    expect(page).to have_content 'Editar Buffet'
    expect(page).to have_field 'Nome Fantasia', with: 'Casamentos Buffet'
    expect(page).to have_field 'Razão Social', with: 'Casamentos Buffet LTDA'
    expect(page).to have_field 'CNPJ', with: '73456164000100'
    expect(page).to have_field 'Telefone', with: '(11)00001111'
    expect(page).to have_field 'E-mail', with: 'casabuffet@email.com'
    expect(page).to have_field 'Endereço', with: 'Av Machado, 650'
    expect(page).to have_field 'Bairro', with: 'Jardim do Sol'
    expect(page).to have_field 'Cidade', with: 'Sales'
    expect(page).to have_field 'Estado', with: 'SP'
    expect(page).to have_field 'CEP', with: '14980-970'
    expect(page).to have_field 'Descrição', with: 'Buffet especializado em casamentos'
  end

  it 'com sucesso' do
    owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
    Buffet.create!(
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
      owner: owner)
    
    login_as(owner)
    visit root_path
    click_on 'Casamentos Buffet'
    click_on 'Editar'
    fill_in 'Nome Fantasia', with: 'Casa Buffet'
    fill_in 'Endereço', with: 'Av Pedra Grande, 55'
    click_on 'Enviar'

    expect(page).to have_content 'Buffet atualizado com sucesso.'
    expect(page).to have_content 'Casa Buffet'
    expect(page).to have_content 'Endereço: Av Pedra Grande, 55 - Jardim do Sol, Sales - SP - 14980-970'
  end
end