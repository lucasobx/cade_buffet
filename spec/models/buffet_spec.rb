require 'rails_helper'

RSpec.describe Buffet, type: :model do
  describe '#full_address' do
    it 'exibe o endereço completo' do
      buffet = Buffet.new(address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP')

      expect(buffet.full_address).to eq 'Av Machado, 650 - Jardim do Sol, Sales - SP'
    end
  end

  describe '#valid?' do
    context 'validations' do
      it 'Dono de buffet não pode cadastrar mais de um buffet' do
        owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
        cash = PaymentMethod.create!(name: 'Dinheiro')
        pix = PaymentMethod.create!(name: 'Pix')
        buffet1 = Buffet.create!(brand_name: 'Casamentos Buffet', corporate_name: 'Casamentos Buffet LTDA',
                                 registration_code: '73456164000100', phone_number: '(11)00001111', email: 'casab@email.com',
                                 address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                                 postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                                 owner: owner, payment_methods: [cash, pix])
        buffet2 = Buffet.new(brand_name: 'Edecy Buffet', corporate_name: 'Edecy Buffet LTDA',
                             registration_code: '55996244000122', phone_number: '(11)22229988', email: 'edecy@email.com',
                             address: 'Rua Castilho, 560', neighborhood: 'Piratininga', city: 'Belo Horizonte', state: 'MG',
                             postal_code: '55280-001', description: 'Buffet para festa infantil',
                             owner: owner, payment_methods: [cash, pix]) 
  
        expect(buffet2).not_to be_valid
        expect(buffet2.errors[:owner]).to include('já possui um buffet cadastrado.')
      end
    end

    context 'presence' do
      it 'Nome Fantasia é obrigatório' do
        owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
        cash = PaymentMethod.create!(name: 'Dinheiro')
        pix = PaymentMethod.create!(name: 'Pix')
        buffet = Buffet.new(brand_name: '', corporate_name: 'Casamentos Buffet LTDA',
                            registration_code: '73456164000100', phone_number: '(11)00001111', email: 'casab@email.com',
                            address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                            postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                            owner: owner, payment_methods: [cash, pix])

        buffet.valid?
        expect(buffet.errors.include? :brand_name).to eq true
      end

      it 'Razão Social é obrigatório' do
        owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
        cash = PaymentMethod.create!(name: 'Dinheiro')
        pix = PaymentMethod.create!(name: 'Pix')
        buffet = Buffet.new(brand_name: 'Casamentos Buffet', corporate_name: '',
                            registration_code: '73456164000100', phone_number: '(11)00001111', email: 'casab@email.com',
                            address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                            postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                            owner: owner, payment_methods: [cash, pix])

        buffet.valid?
        expect(buffet.errors.include? :corporate_name).to eq true
      end

      it 'CNPJ é obrigatório' do
        owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
        cash = PaymentMethod.create!(name: 'Dinheiro')
        pix = PaymentMethod.create!(name: 'Pix')
        buffet = Buffet.new(brand_name: 'Casamentos Buffet', corporate_name: 'Casamentos Buffet LTDA',
                            registration_code: '', phone_number: '(11)00001111', email: 'casab@email.com',
                            address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                            postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                            owner: owner, payment_methods: [cash, pix])

        buffet.valid?
        expect(buffet.errors.include? :registration_code).to eq true
      end

      it 'Telefone é obrigatório' do
        owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
        cash = PaymentMethod.create!(name: 'Dinheiro')
        pix = PaymentMethod.create!(name: 'Pix')
        buffet = Buffet.new(brand_name: 'Casamentos Buffet', corporate_name: 'Casamentos Buffet LTDA',
                            registration_code: '73456164000100', phone_number: '', email: 'casab@email.com',
                            address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                            postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                            owner: owner, payment_methods: [cash, pix])

        buffet.valid?
        expect(buffet.errors.include? :phone_number).to eq true
      end

      it 'E-mail é obrigatório' do
        owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
        cash = PaymentMethod.create!(name: 'Dinheiro')
        pix = PaymentMethod.create!(name: 'Pix')
        buffet = Buffet.new(brand_name: 'Casamentos Buffet', corporate_name: 'Casamentos Buffet LTDA',
                            registration_code: '73456164000100', phone_number: '(11)00001111', email: '',
                            address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                            postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                            owner: owner, payment_methods: [cash, pix])

        buffet.valid?
        expect(buffet.errors.include? :email).to eq true
      end

      it 'Endereço é obrigatório' do
        owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
        cash = PaymentMethod.create!(name: 'Dinheiro')
        pix = PaymentMethod.create!(name: 'Pix')
        buffet = Buffet.new(brand_name: 'Casamentos Buffet', corporate_name: 'Casamentos Buffet LTDA',
                            registration_code: '73456164000100', phone_number: '(11)00001111', email: 'casab@email.com',
                            address: '', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                            postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                            owner: owner, payment_methods: [cash, pix])

        buffet.valid?
        expect(buffet.errors.include? :address).to eq true
      end

      it 'Bairro é obrigatório' do
        owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
        cash = PaymentMethod.create!(name: 'Dinheiro')
        pix = PaymentMethod.create!(name: 'Pix')
        buffet = Buffet.new(brand_name: 'Casamentos Buffet', corporate_name: 'Casamentos Buffet LTDA',
                            registration_code: '73456164000100', phone_number: '(11)00001111', email: 'casab@email.com',
                            address: 'Av Machado, 650', neighborhood: '', city: 'Sales', state: 'SP',
                            postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                            owner: owner, payment_methods: [cash, pix])

        buffet.valid?
        expect(buffet.errors.include? :neighborhood).to eq true
      end

      it 'Cidade é obrigatório' do
        owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
        cash = PaymentMethod.create!(name: 'Dinheiro')
        pix = PaymentMethod.create!(name: 'Pix')
        buffet = Buffet.new(brand_name: 'Casamentos Buffet', corporate_name: 'Casamentos Buffet LTDA',
                            registration_code: '73456164000100', phone_number: '(11)00001111', email: 'casab@email.com',
                            address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: '', state: 'SP',
                            postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                            owner: owner, payment_methods: [cash, pix])

        buffet.valid?
        expect(buffet.errors.include? :city).to eq true
      end

      it 'Estado é obrigatório' do
        owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
        cash = PaymentMethod.create!(name: 'Dinheiro')
        pix = PaymentMethod.create!(name: 'Pix')
        buffet = Buffet.new(brand_name: 'Casamentos Buffet', corporate_name: 'Casamentos Buffet LTDA',
                            registration_code: '73456164000100', phone_number: '(11)00001111', email: 'casab@email.com',
                            address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: 'Sales', state: '',
                            postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                            owner: owner, payment_methods: [cash, pix])

        buffet.valid?
        expect(buffet.errors.include? :state).to eq true
      end

      it 'CEP é obrigatório' do
        owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
        cash = PaymentMethod.create!(name: 'Dinheiro')
        pix = PaymentMethod.create!(name: 'Pix')
        buffet = Buffet.new(brand_name: 'Casamentos Buffet', corporate_name: 'Casamentos Buffet LTDA',
                            registration_code: '73456164000100', phone_number: '(11)00001111', email: 'casab@email.com',
                            address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                            postal_code: '', description: 'Buffet especializado em casamentos',
                            owner: owner, payment_methods: [cash, pix])

        buffet.valid?
        expect(buffet.errors.include? :postal_code).to eq true
      end

      it 'Descrição é obrigatório' do
        owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
        cash = PaymentMethod.create!(name: 'Dinheiro')
        pix = PaymentMethod.create!(name: 'Pix')
        buffet = Buffet.new(brand_name: 'Casamentos Buffet', corporate_name: 'Casamentos Buffet LTDA',
                            registration_code: '73456164000100', phone_number: '(11)00001111', email: 'casab@email.com',
                            address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                            postal_code: '14980-970', description: '',
                            owner: owner, payment_methods: [cash, pix])

        buffet.valid?
        expect(buffet.errors.include? :description).to eq true
      end

      it 'Método de pagamento é obrigatório' do
        owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
        PaymentMethod.create!(name: 'Dinheiro')
        PaymentMethod.create!(name: 'Pix')
        buffet = Buffet.new(brand_name: 'Casamentos Buffet', corporate_name: 'Casamentos Buffet LTDA',
                            registration_code: '73456164000100', phone_number: '(11)00001111', email: 'casab@email.com',
                            address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                            postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                            owner: owner, payment_methods: [])

        buffet.valid?
        expect(buffet.errors.include? :payment_methods).to eq true
      end
    end

    context 'uniqueness' do
      it 'CNPJ deve ser único' do
        owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
        second_owner = Owner.create!(name: 'Julia', email: 'julia@email.com', password: '12345678')
        cash = PaymentMethod.create!(name: 'Dinheiro')
        pix = PaymentMethod.create!(name: 'Pix')
        buffet1 = Buffet.create!(brand_name: 'Casamentos Buffet', corporate_name: 'Casamentos Buffet LTDA',
                                registration_code: '73456164000100', phone_number: '(11)00001111', email: 'casab@email.com',
                                address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                                postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                                owner: owner, payment_methods: [cash, pix])
        buffet2 = Buffet.new(brand_name: 'Buffet da Julia', corporate_name: 'Buffet da Julia LTDA',
                              registration_code: '73456164000100', phone_number: '(62)88887755', email: 'jbuffet@email.com',
                              address: 'Av Corifeu, 10', neighborhood: 'Butantã', city: 'São Paulo', state: 'SP',
                              postal_code: '056980-070', description: 'Buffet especializado em festas infantis',
                              owner: second_owner, payment_methods: [cash, pix])                            

        expect(buffet2.valid?).to eq false
      end
    end
  end
end