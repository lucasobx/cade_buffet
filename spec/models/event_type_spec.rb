require 'rails_helper'

RSpec.describe EventType, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'nome é obrigatório' do
        owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
        cash = PaymentMethod.create!(name: 'Dinheiro')
        pix = PaymentMethod.create!(name: 'Pix')
        buffet = Buffet.create!(brand_name: 'Casamentos Buffet', corporate_name: 'Casamentos Buffet LTDA',
                                registration_code: '73456164000100', phone_number: '(11)00001111', email: 'casab@email.com',
                                address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                                postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                                owner: owner, payment_methods: [cash, pix])
        event = EventType.new(name: '',
                              description: 'Espaço luxuoso e confortável',
                              min_guests: 15, max_guests: 150, duration: 240,
                              menu_details: 'Doces, Salgados, Bebidas',
                              alcohol_option: true, decoration_option: true, parking_service_option: true,
                              location_option: false, buffet: buffet, base_price: 15000.0, extra_guest: 250.0,
                              extra_hour: 1000.0, we_base_price: 15000.0, we_extra_guest: 400.0, we_extra_hour: 1500.0)

        event.valid?
        expect(event.errors.include? :name).to be true
      end

      it 'descrição é obrigatório' do
        owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
        cash = PaymentMethod.create!(name: 'Dinheiro')
        pix = PaymentMethod.create!(name: 'Pix')
        buffet = Buffet.create!(brand_name: 'Casamentos Buffet', corporate_name: 'Casamentos Buffet LTDA',
                                registration_code: '73456164000100', phone_number: '(11)00001111', email: 'casab@email.com',
                                address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                                postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                                owner: owner, payment_methods: [cash, pix])
        event = EventType.new(name: 'Festa de Casamento',
                              description: '',
                              min_guests: 15, max_guests: 150, duration: 240,
                              menu_details: 'Doces, Salgados, Bebidas',
                              alcohol_option: true, decoration_option: true, parking_service_option: true,
                              location_option: false, buffet: buffet, base_price: 15000.0, extra_guest: 250.0,
                              extra_hour: 1000.0, we_base_price: 15000.0, we_extra_guest: 400.0, we_extra_hour: 1500.0)

        event.valid?
        expect(event.errors.include? :description).to be true
      end

      it 'mínimo de convidados é obrigatório' do
        owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
        cash = PaymentMethod.create!(name: 'Dinheiro')
        pix = PaymentMethod.create!(name: 'Pix')
        buffet = Buffet.create!(brand_name: 'Casamentos Buffet', corporate_name: 'Casamentos Buffet LTDA',
                                registration_code: '73456164000100', phone_number: '(11)00001111', email: 'casab@email.com',
                                address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                                postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                                owner: owner, payment_methods: [cash, pix])
        event = EventType.new(name: 'Festa de Casamento',
                              description: 'Espaço luxuoso e confortável',
                              min_guests: '', max_guests: 150, duration: 240,
                              menu_details: 'Doces, Salgados, Bebidas',
                              alcohol_option: true, decoration_option: true, parking_service_option: true,
                              location_option: false, buffet: buffet, base_price: 15000.0, extra_guest: 250.0,
                              extra_hour: 1000.0, we_base_price: 15000.0, we_extra_guest: 400.0, we_extra_hour: 1500.0)

        event.valid?
        expect(event.errors.include? :min_guests).to be true
      end

      it 'máximo de convidados é obrigatório' do
        owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
        cash = PaymentMethod.create!(name: 'Dinheiro')
        pix = PaymentMethod.create!(name: 'Pix')
        buffet = Buffet.create!(brand_name: 'Casamentos Buffet', corporate_name: 'Casamentos Buffet LTDA',
                                registration_code: '73456164000100', phone_number: '(11)00001111', email: 'casab@email.com',
                                address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                                postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                                owner: owner, payment_methods: [cash, pix])
        event = EventType.new(name: 'Festa de Casamento',
                              description: 'Espaço luxuoso e confortável',
                              min_guests: 15, max_guests: '', duration: 240,
                              menu_details: 'Doces, Salgados, Bebidas',
                              alcohol_option: true, decoration_option: true, parking_service_option: true,
                              location_option: false, buffet: buffet, base_price: 15000.0, extra_guest: 250.0,
                              extra_hour: 1000.0, we_base_price: 15000.0, we_extra_guest: 400.0, we_extra_hour: 1500.0)

        event.valid?
        expect(event.errors.include? :max_guests).to be true
      end

      it 'duração é obrigatório' do
        owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
        cash = PaymentMethod.create!(name: 'Dinheiro')
        pix = PaymentMethod.create!(name: 'Pix')
        buffet = Buffet.create!(brand_name: 'Casamentos Buffet', corporate_name: 'Casamentos Buffet LTDA',
                                registration_code: '73456164000100', phone_number: '(11)00001111', email: 'casab@email.com',
                                address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                                postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                                owner: owner, payment_methods: [cash, pix])
        event = EventType.new(name: 'Festa de Casamento',
                              description: 'Espaço luxuoso e confortável',
                              min_guests: 15, max_guests: 150, duration: '',
                              menu_details: 'Doces, Salgados, Bebidas',
                              alcohol_option: true, decoration_option: true, parking_service_option: true,
                              location_option: false, buffet: buffet, base_price: 15000.0, extra_guest: 250.0,
                              extra_hour: 1000.0, we_base_price: 15000.0, we_extra_guest: 400.0, we_extra_hour: 1500.0)

        event.valid?
        expect(event.errors.include? :duration).to be true
      end

      it 'cardápio é obrigatório' do
        owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
        cash = PaymentMethod.create!(name: 'Dinheiro')
        pix = PaymentMethod.create!(name: 'Pix')
        buffet = Buffet.create!(brand_name: 'Casamentos Buffet', corporate_name: 'Casamentos Buffet LTDA',
                                registration_code: '73456164000100', phone_number: '(11)00001111', email: 'casab@email.com',
                                address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                                postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                                owner: owner, payment_methods: [cash, pix])
        event = EventType.new(name: 'Festa de Casamento',
                              description: 'Espaço luxuoso e confortável',
                              min_guests: 15, max_guests: 150, duration: 240,
                              menu_details: '',
                              alcohol_option: true, decoration_option: true, parking_service_option: true,
                              location_option: false, buffet: buffet, base_price: 15000.0, extra_guest: 250.0,
                              extra_hour: 1000.0, we_base_price: 15000.0, we_extra_guest: 400.0, we_extra_hour: 1500.0)

        event.valid?
        expect(event.errors.include? :menu_details).to be true
      end

      it 'preço base é obrigatório' do
        owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
        cash = PaymentMethod.create!(name: 'Dinheiro')
        pix = PaymentMethod.create!(name: 'Pix')
        buffet = Buffet.create!(brand_name: 'Casamentos Buffet', corporate_name: 'Casamentos Buffet LTDA',
                                registration_code: '73456164000100', phone_number: '(11)00001111', email: 'casab@email.com',
                                address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                                postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                                owner: owner, payment_methods: [cash, pix])
        event = EventType.new(name: 'Festa de Casamento',
                              description: 'Espaço luxuoso e confortável',
                              min_guests: 15, max_guests: 150, duration: 240,
                              menu_details: 'Doces, Salgados, Bebidas',
                              alcohol_option: true, decoration_option: true, parking_service_option: true,
                              location_option: false, buffet: buffet, base_price: '', extra_guest: 250.0,
                              extra_hour: 1000.0, we_base_price: 15000.0, we_extra_guest: 400.0, we_extra_hour: 1500.0)

        event.valid?
        expect(event.errors.include? :base_price).to be true
      end

      it 'taxa por pessoa excedente é obrigatório' do
        owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
        cash = PaymentMethod.create!(name: 'Dinheiro')
        pix = PaymentMethod.create!(name: 'Pix')
        buffet = Buffet.create!(brand_name: 'Casamentos Buffet', corporate_name: 'Casamentos Buffet LTDA',
                                registration_code: '73456164000100', phone_number: '(11)00001111', email: 'casab@email.com',
                                address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                                postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                                owner: owner, payment_methods: [cash, pix])
        event = EventType.new(name: 'Festa de Casamento',
                              description: 'Espaço luxuoso e confortável',
                              min_guests: 15, max_guests: 150, duration: 240,
                              menu_details: 'Doces, Salgados, Bebidas',
                              alcohol_option: true, decoration_option: true, parking_service_option: true,
                              location_option: false, buffet: buffet, base_price: 15000.0, extra_guest: '',
                              extra_hour: 1000.0, we_base_price: 15000.0, we_extra_guest: 400.0, we_extra_hour: 1500.0)

        event.valid?
        expect(event.errors.include? :extra_guest).to be true
      end

      it 'taxa por hora extra é obrigatório' do
        owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
        cash = PaymentMethod.create!(name: 'Dinheiro')
        pix = PaymentMethod.create!(name: 'Pix')
        buffet = Buffet.create!(brand_name: 'Casamentos Buffet', corporate_name: 'Casamentos Buffet LTDA',
                                registration_code: '73456164000100', phone_number: '(11)00001111', email: 'casab@email.com',
                                address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                                postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                                owner: owner, payment_methods: [cash, pix])
        event = EventType.new(name: 'Festa de Casamento',
                              description: 'Espaço luxuoso e confortável',
                              min_guests: 15, max_guests: 150, duration: 240,
                              menu_details: 'Doces, Salgados, Bebidas',
                              alcohol_option: true, decoration_option: true, parking_service_option: true,
                              location_option: false, buffet: buffet, base_price: 15000.0, extra_guest: 250.0,
                              extra_hour: '', we_base_price: 15000.0, we_extra_guest: 400.0, we_extra_hour: 1500.0)

        event.valid?
        expect(event.errors.include? :extra_hour).to be true
      end

      it 'preço no fim de semana é obrigatório' do
        owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
        cash = PaymentMethod.create!(name: 'Dinheiro')
        pix = PaymentMethod.create!(name: 'Pix')
        buffet = Buffet.create!(brand_name: 'Casamentos Buffet', corporate_name: 'Casamentos Buffet LTDA',
                                registration_code: '73456164000100', phone_number: '(11)00001111', email: 'casab@email.com',
                                address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                                postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                                owner: owner, payment_methods: [cash, pix])
        event = EventType.new(name: 'Festa de Casamento',
                              description: 'Espaço luxuoso e confortável',
                              min_guests: 15, max_guests: 150, duration: 240,
                              menu_details: 'Doces, Salgados, Bebidas',
                              alcohol_option: true, decoration_option: true, parking_service_option: true,
                              location_option: false, buffet: buffet, base_price: 15000.0, extra_guest: 250.0,
                              extra_hour: 1000.0, we_base_price: '', we_extra_guest: 400.0, we_extra_hour: 1500.0)

        event.valid?
        expect(event.errors.include? :we_base_price).to be true
      end

      it 'taxa por pessoa excedente no fim de semana é obrigatório' do
        owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
        cash = PaymentMethod.create!(name: 'Dinheiro')
        pix = PaymentMethod.create!(name: 'Pix')
        buffet = Buffet.create!(brand_name: 'Casamentos Buffet', corporate_name: 'Casamentos Buffet LTDA',
                                registration_code: '73456164000100', phone_number: '(11)00001111', email: 'casab@email.com',
                                address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                                postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                                owner: owner, payment_methods: [cash, pix])
        event = EventType.new(name: 'Festa de Casamento',
                              description: 'Espaço luxuoso e confortável',
                              min_guests: 15, max_guests: 150, duration: 240,
                              menu_details: 'Doces, Salgados, Bebidas',
                              alcohol_option: true, decoration_option: true, parking_service_option: true,
                              location_option: false, buffet: buffet, base_price: 15000.0, extra_guest: 250.0,
                              extra_hour: 1000.0, we_base_price: 15000.0, we_extra_guest: '', we_extra_hour: 1500.0)

        event.valid?
        expect(event.errors.include? :we_extra_guest).to be true
      end

      it 'taxa por hora extra no fim de semana é obrigatório' do
        owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
        cash = PaymentMethod.create!(name: 'Dinheiro')
        pix = PaymentMethod.create!(name: 'Pix')
        buffet = Buffet.create!(brand_name: 'Casamentos Buffet', corporate_name: 'Casamentos Buffet LTDA',
                                registration_code: '73456164000100', phone_number: '(11)00001111', email: 'casab@email.com',
                                address: 'Av Machado, 650', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                                postal_code: '14980-970', description: 'Buffet especializado em casamentos',
                                owner: owner, payment_methods: [cash, pix])
        event = EventType.new(name: 'Festa de Casamento',
                              description: 'Espaço luxuoso e confortável',
                              min_guests: 15, max_guests: 150, duration: 240,
                              menu_details: 'Doces, Salgados, Bebidas',
                              alcohol_option: true, decoration_option: true, parking_service_option: true,
                              location_option: false, buffet: buffet, base_price: 15000.0, extra_guest: 250.0,
                              extra_hour: 1000.0, we_base_price: 15000.0, we_extra_guest: 400.0, we_extra_hour: '')

        event.valid?
        expect(event.errors.include? :we_extra_hour).to be true
      end
    end
  end
end