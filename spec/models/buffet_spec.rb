require 'rails_helper'

RSpec.describe Buffet, type: :model do
  describe '#valid?' do
    context 'presence' do
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

    context 'uniqueness' do
      it 'CNPJ deve ser único' do
        owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
        second_owner = Owner.create!(name: 'Julia', email: 'julia@email.com', password: '12345678')
        cash = PaymentMethod.create!(name: 'Dinheiro')
        pix = PaymentMethod.create!(name: 'Pix')
        buffet = Buffet.create!(
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
          owner: owner,
          payment_methods: [cash, pix])
        second_buffet = Buffet.new(
          brand_name: 'Buffet da Julia',
          corporate_name: 'Buffet da Julia LTDA',
          registration_code: '73456164000100',
          phone_number: '(62)88887755',
          email: 'juliabuffet@email.com',
          address: 'Av Corifeu, 10',
          neighborhood: 'Butantã',
          city: 'São Paulo',
          state: 'SP',
          postal_code: '056980-070',
          description: 'Buffet especializado em festas infantis',
          owner: second_owner,
          payment_methods: [cash, pix])

        expect(second_buffet.valid?).to eq false
      end
    end
  end
end
