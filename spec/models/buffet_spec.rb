require 'rails_helper'

RSpec.describe Buffet, type: :model do
  describe '#valid?' do
    it 'Nome Fantasia é obrigatório' do
      owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
      cash = PaymentMethod.create!(name: 'Dinheiro')
      pix = PaymentMethod.create!(name: 'Pix')
      buffet = Buffet.new(
        brand_name: '',
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
        owner: owner,
        payment_methods: [cash, pix])

      expect(buffet.valid?).to eq false
    end

    it 'Razão Social é obrigatório' do
      owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
      cash = PaymentMethod.create!(name: 'Dinheiro')
      pix = PaymentMethod.create!(name: 'Pix')
      buffet = Buffet.new(
        brand_name: 'Casamentos Buffet',
        corporate_name: '',
        registration_code: '73456164000100',
        phone_number: '(11)00001111',
        email: 'casabuffet@email.com',
        address: 'Av Machado, 650',
        neighborhood: 'Jardim do Sol',
        city: 'Sales',
        state: 'SP',
        postal_code: '14980-970',
        description: 'Buffet especializado em casamentos',
        owner: owner,
        payment_methods: [cash, pix])

      expect(buffet.valid?).to eq false
    end

    it 'CNPJ é obrigatório' do
      owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
      cash = PaymentMethod.create!(name: 'Dinheiro')
      pix = PaymentMethod.create!(name: 'Pix')
      buffet = Buffet.new(
        brand_name: 'Casamentos Buffet',
        corporate_name: 'Casamentos Buffet LTDA',
        registration_code: '',
        phone_number: '(11)00001111',
        email: 'casabuffet@email.com',
        address: 'Av Machado, 650',
        neighborhood: 'Jardim do Sol',
        city: 'Sales',
        state: 'SP',
        postal_code: '14980-970',
        description: 'Buffet especializado em casamentos',
        owner: owner,
        payment_methods: [cash, pix])

      expect(buffet.valid?).to eq false
    end

    it 'Telefone é obrigatório' do
      owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
      cash = PaymentMethod.create!(name: 'Dinheiro')
      pix = PaymentMethod.create!(name: 'Pix')
      buffet = Buffet.new(
        brand_name: 'Casamentos Buffet',
        corporate_name: 'Casamentos Buffet LTDA',
        registration_code: '73456164000100',
        phone_number: '',
        email: 'casabuffet@email.com',
        address: 'Av Machado, 650',
        neighborhood: 'Jardim do Sol',
        city: 'Sales',
        state: 'SP',
        postal_code: '14980-970',
        description: 'Buffet especializado em casamentos',
        owner: owner,
        payment_methods: [cash, pix])

      expect(buffet.valid?).to eq false
    end

    it 'E-mail é obrigatório' do
      owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
      cash = PaymentMethod.create!(name: 'Dinheiro')
      pix = PaymentMethod.create!(name: 'Pix')
      buffet = Buffet.new(
        brand_name: 'Casamentos Buffet',
        corporate_name: 'Casamentos Buffet LTDA',
        registration_code: '73456164000100',
        phone_number: '(11)00001111',
        email: '',
        address: 'Av Machado, 650',
        neighborhood: 'Jardim do Sol',
        city: 'Sales',
        state: 'SP',
        postal_code: '14980-970',
        description: 'Buffet especializado em casamentos',
        owner: owner,
        payment_methods: [cash, pix])

      expect(buffet.valid?).to eq false
    end

    it 'Endereço é obrigatório' do
      owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
      cash = PaymentMethod.create!(name: 'Dinheiro')
      pix = PaymentMethod.create!(name: 'Pix')
      buffet = Buffet.new(
        brand_name: 'Casamentos Buffet',
        corporate_name: 'Casamentos Buffet LTDA',
        registration_code: '73456164000100',
        phone_number: '(11)00001111',
        email: 'casabuffet@email.com',
        address: '',
        neighborhood: 'Jardim do Sol',
        city: 'Sales',
        state: 'SP',
        postal_code: '14980-970',
        description: 'Buffet especializado em casamentos',
        owner: owner,
        payment_methods: [cash, pix])

      expect(buffet.valid?).to eq false
    end

    it 'Bairro é obrigatório' do
      owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
      cash = PaymentMethod.create!(name: 'Dinheiro')
      pix = PaymentMethod.create!(name: 'Pix')
      buffet = Buffet.new(
        brand_name: 'Casamentos Buffet',
        corporate_name: 'Casamentos Buffet LTDA',
        registration_code: '73456164000100',
        phone_number: '(11)00001111',
        email: 'casabuffet@email.com',
        address: 'Av Machado, 650',
        neighborhood: '',
        city: 'Sales',
        state: 'SP',
        postal_code: '14980-970',
        description: 'Buffet especializado em casamentos',
        owner: owner,
        payment_methods: [cash, pix])

      expect(buffet.valid?).to eq false
    end

    it 'Cidade é obrigatório' do
      owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
      cash = PaymentMethod.create!(name: 'Dinheiro')
      pix = PaymentMethod.create!(name: 'Pix')
      buffet = Buffet.new(
        brand_name: 'Casamentos Buffet',
        corporate_name: 'Casamentos Buffet LTDA',
        registration_code: '73456164000100',
        phone_number: '(11)00001111',
        email: 'casabuffet@email.com',
        address: 'Av Machado, 650',
        neighborhood: 'Jardim do Sol',
        city: '',
        state: 'SP',
        postal_code: '14980-970',
        description: 'Buffet especializado em casamentos',
        owner: owner,
        payment_methods: [cash, pix])

      expect(buffet.valid?).to eq false
    end

    it 'Estado é obrigatório' do
      owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
      cash = PaymentMethod.create!(name: 'Dinheiro')
      pix = PaymentMethod.create!(name: 'Pix')
      buffet = Buffet.new(
        brand_name: 'Casamentos Buffet',
        corporate_name: 'Casamentos Buffet LTDA',
        registration_code: '73456164000100',
        phone_number: '(11)00001111',
        email: 'casabuffet@email.com',
        address: 'Av Machado, 650',
        neighborhood: 'Jardim do Sol',
        city: 'Sales',
        state: '',
        postal_code: '14980-970',
        description: 'Buffet especializado em casamentos',
        owner: owner,
        payment_methods: [cash, pix])

      expect(buffet.valid?).to eq false
    end

    it 'CEP é obrigatório' do
      owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
      cash = PaymentMethod.create!(name: 'Dinheiro')
      pix = PaymentMethod.create!(name: 'Pix')
      buffet = Buffet.new(
        brand_name: 'Casamentos Buffet',
        corporate_name: 'Casamentos Buffet LTDA',
        registration_code: '73456164000100',
        phone_number: '(11)00001111',
        email: 'casabuffet@email.com',
        address: 'Av Machado, 650',
        neighborhood: 'Jardim do Sol',
        city: 'Sales',
        state: 'SP',
        postal_code: '',
        description: 'Buffet especializado em casamentos',
        owner: owner,
        payment_methods: [cash, pix])

      expect(buffet.valid?).to eq false
    end

    it 'Descrição é obrigatório' do
      owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
      cash = PaymentMethod.create!(name: 'Dinheiro')
      pix = PaymentMethod.create!(name: 'Pix')
      buffet = Buffet.new(
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
        description: '',
        owner: owner,
        payment_methods: [cash, pix])

      expect(buffet.valid?).to eq false
    end

    it 'Método de pagamento é obrigatório' do
      owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
      cash = PaymentMethod.create!(name: 'Dinheiro')
      pix = PaymentMethod.create!(name: 'Pix')
      buffet = Buffet.new(
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

      expect(buffet.valid?).to eq false
    end
  end
end
