require 'rails_helper'

describe 'Usuário visita tela inicial' do
  it 'e vê o nome da aplicação' do
    visit root_path

    expect(page).to have_content 'Cade Buffet?'
    expect(page).to have_link 'Cade Buffet?', href: root_path
  end
end