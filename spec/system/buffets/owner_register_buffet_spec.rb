require 'rails_helper'

describe 'Proprietário cadastra um Buffet' do
  it 'com sucesso' do
    owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')

    login_as(owner)
    visit root_path
    click_on 'Cadastrar Novo Buffet'
    fill_in 'Nome Fantasia', with: 'Casamentos Buffet'
    fill_in 'Razão Social', with: 'Casamentos Buffet LTDA'
    fill_in 'CNPJ', with: '73456164000100'
    fill_in 'Telefone', with: '(11)00001111'
    fill_in 'E-mail', with: 'casabuffet@email.com'
    fill_in 'Endereço', with: 'Av Machado, 650'
    fill_in 'Bairro', with: 'Jardim do Sol'
    fill_in 'Cidade', with: 'Sales'
    fill_in 'Estado', with: 'SP'
    fill_in 'CEP', with: '14980-970'
    fill_in 'Descrição', with: 'Buffet especializado em casamentos'
    click_on 'Enviar'

    expect(page).to have_content 'Buffet cadastrado com sucesso.'
    expect(page).to have_content 'Casamentos Buffet'
    expect(page).to have_content 'Razão Social: Casamentos Buffet LTDA'
    expect(page).to have_content 'Descrição: Buffet especializado em casamentos'
    expect(page).to have_content 'Contato: (11)00001111 - casabuffet@email.com'
    expect(page).to have_content 'Endereço: Av Machado, 650 - Jardim do Sol, Sales - SP - 14980-970'
  end
end