require 'rails_helper'

RSpec.describe EventType, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'Nome é obrigatório' do
        owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
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
        event_type = EventType.new(
          name: '',
          description: 'Espaço luxuoso e confortável',
          min_guests: 15,
          max_guests: 150,
          duration: 240,
          menu_details: 'Doces, Salgados, Bebidas',
          alcohol_option: true,
          decoration_option: true,
          parking_service_option: true,
          location_option: false,
          buffet: buffet)

        expect(event_type.valid?).to eq false
      end

      it 'Descrição é obrigatório' do
        owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
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
        event_type = EventType.new(
          name: 'Festa de Casamento',
          description: '',
          min_guests: 15,
          max_guests: 150,
          duration: 240,
          menu_details: 'Doces, Salgados, Bebidas',
          alcohol_option: true,
          decoration_option: true,
          parking_service_option: true,
          location_option: false,
          buffet: buffet)

        expect(event_type.valid?).to eq false
      end

      it 'Mínimo de Convidados é obrigatório' do
        owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
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
        event_type = EventType.new(
          name: 'Festa de Casamento',
          description: 'Espaço luxuoso e confortável',
          min_guests: '',
          max_guests: 150,
          duration: 240,
          menu_details: 'Doces, Salgados, Bebidas',
          alcohol_option: true,
          decoration_option: true,
          parking_service_option: true,
          location_option: false,
          buffet: buffet)

        expect(event_type.valid?).to eq false
      end

      it 'Máximo de Convidados é obrigatório' do
        owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
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
        event_type = EventType.new(
          name: 'Festa de Casamento',
          description: 'Espaço luxuoso e confortável',
          min_guests: 15,
          max_guests: '',
          duration: 240,
          menu_details: 'Doces, Salgados, Bebidas',
          alcohol_option: true,
          decoration_option: true,
          parking_service_option: true,
          location_option: false,
          buffet: buffet)

        expect(event_type.valid?).to eq false
      end

      it 'Duração é obrigatório' do
        owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
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
        event_type = EventType.new(
          name: 'Festa de Casamento',
          description: 'Espaço luxuoso e confortável',
          min_guests: 15,
          max_guests: 150,
          duration: '',
          menu_details: 'Doces, Salgados, Bebidas',
          alcohol_option: true,
          decoration_option: true,
          parking_service_option: true,
          location_option: false,
          buffet: buffet)

        expect(event_type.valid?).to eq false
      end

      it 'Cardápio é obrigatório' do
        owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
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
        event_type = EventType.new(
          name: 'Festa de Casamento',
          description: 'Espaço luxuoso e confortável',
          min_guests: 15,
          max_guests: 150,
          duration: 240,
          menu_details: '',
          alcohol_option: true,
          decoration_option: true,
          parking_service_option: true,
          location_option: false,
          buffet: buffet)

        expect(event_type.valid?).to eq false
      end
    end
  end
end
