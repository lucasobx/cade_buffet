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
  owner: f_owner)
Buffet.create!(
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
  owner: s_owner)