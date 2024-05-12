require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do
    it 'deve ter um código' do
      client = Client.create!(name: 'Julia', personal_code: '94641091064', email: 'julia@email.com', password: '12345678')
      owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
      cash = PaymentMethod.create!(name: 'Dinheiro')
      pix = PaymentMethod.create!(name: 'Pix')
      buffet = Buffet.create!(brand_name: 'Miniland', corporate_name: 'Miniland LTDA',
                              registration_code: '00556164220103', phone_number: '(11)32441110', email: 'miniland@email.com',
                              address: 'Av Martins, 50', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                              postal_code: '14770-070', description: 'Buffet especializado em festas temáticas',
                              owner: owner, payment_methods: [cash, pix])
      event = EventType.create!(name: 'Festa dos Heróis', description: 'Festa infantil com temática de heróis',
                                min_guests: 10, max_guests: 80, duration: 240,
                                menu_details: 'Doces, Salgados, Bebidas',
                                alcohol_option: false, decoration_option: true, parking_service_option: true,
                                location_option: true, buffet: buffet, base_price: 5000.0, extra_guest: 100.0,
                                extra_hour: 500.0, we_base_price: 8000.0, we_extra_guest: 200.0, we_extra_hour: 800.0)
      order = Order.new(client: client, buffet: buffet, event_type: event, event_date: '10/10/2050',
                        estimated_guests: 30, event_details: 'Festa de aniversário', event_address: 'Rua das Flores') 

      expect(order.valid?).to be true
    end

    it 'data é obrigatória' do
      order = Order.new(event_date: '')

      order.valid?

      expect(order.errors.include? :event_date).to be true
    end

    it 'data não deve ser passada' do
      order = Order.new(event_date: 1.day.ago)

      order.valid?

      expect(order.errors.include? :event_date).to be true
      expect(order.errors[:event_date]).to include "deve ser futura."
    end

    it 'data não deve ser igual a hoje' do
      order = Order.new(event_date: Date.today)

      order.valid?

      expect(order.errors.include? :event_date).to be true
      expect(order.errors[:event_date]).to include "deve ser futura."
    end

    it 'data deve ser igual ou maior que amanhã' do
      order = Order.new(event_date: 1.day.from_now)

      order.valid?

      expect(order.errors.include? :event_date).to be false
    end

    it 'número de convidados é obrigatório' do
      order = Order.new(estimated_guests: '')

      order.valid?

      expect(order.errors.include? :estimated_guests).to be true
    end
  end

  describe 'gera um código aleatório' do
    it 'ao criar um novo pedido' do
      client = Client.create!(name: 'Julia', personal_code: '94641091064', email: 'julia@email.com', password: '12345678')
      owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
      cash = PaymentMethod.create!(name: 'Dinheiro')
      pix = PaymentMethod.create!(name: 'Pix')
      buffet = Buffet.create!(brand_name: 'Miniland', corporate_name: 'Miniland LTDA',
                              registration_code: '00556164220103', phone_number: '(11)32441110', email: 'miniland@email.com',
                              address: 'Av Martins, 50', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                              postal_code: '14770-070', description: 'Buffet especializado em festas temáticas',
                              owner: owner, payment_methods: [cash, pix])
      event = EventType.create!(name: 'Festa dos Heróis', description: 'Festa infantil com temática de heróis',
                                min_guests: 10, max_guests: 80, duration: 240,
                                menu_details: 'Doces, Salgados, Bebidas',
                                alcohol_option: false, decoration_option: true, parking_service_option: true,
                                location_option: true, buffet: buffet, base_price: 5000.0, extra_guest: 100.0,
                                extra_hour: 500.0, we_base_price: 8000.0, we_extra_guest: 200.0, we_extra_hour: 800.0)
      order = Order.new(client: client, buffet: buffet, event_type: event, event_date: '10/10/2050',
                        estimated_guests: 30, event_details: 'Festa de aniversário', event_address: 'Rua das Flores')

      order.save!
      
      expect(order.code).not_to be_empty
      expect(order.code.length).to eq 8
    end

    it 'e o código é único' do
      client = Client.create!(name: 'Julia', personal_code: '94641091064', email: 'julia@email.com', password: '12345678')
      owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
      cash = PaymentMethod.create!(name: 'Dinheiro')
      pix = PaymentMethod.create!(name: 'Pix')
      buffet = Buffet.create!(brand_name: 'Miniland', corporate_name: 'Miniland LTDA',
                              registration_code: '00556164220103', phone_number: '(11)32441110', email: 'miniland@email.com',
                              address: 'Av Martins, 50', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                              postal_code: '14770-070', description: 'Buffet especializado em festas temáticas',
                              owner: owner, payment_methods: [cash, pix])
      event = EventType.create!(name: 'Festa dos Heróis', description: 'Festa infantil com temática de heróis',
                                min_guests: 10, max_guests: 80, duration: 240,
                                menu_details: 'Doces, Salgados, Bebidas',
                                alcohol_option: false, decoration_option: true, parking_service_option: true,
                                location_option: true, buffet: buffet, base_price: 5000.0, extra_guest: 100.0,
                                extra_hour: 500.0, we_base_price: 8000.0, we_extra_guest: 200.0, we_extra_hour: 800.0)
      order1 = Order.create!(client: client, buffet: buffet, event_type: event, event_date: '10/10/2050',
                              estimated_guests: 30, event_details: 'Festa de aniversário', event_address: 'Rua das Flores')
      order2 = Order.new(client: client, buffet: buffet, event_type: event, event_date: '10/10/2030',
                          estimated_guests: 30, event_details: 'Festa de aniversário', event_address: 'Rua das Flores')                             

      order2.save!

      expect(order2.code).not_to eq order1.code
    end

    it 'e não deve ser modificado' do
      client = Client.create!(name: 'Julia', personal_code: '94641091064', email: 'julia@email.com', password: '12345678')
      owner = Owner.create!(name: 'Jorge', email: 'jorge@email.com', password: '12345678')
      cash = PaymentMethod.create!(name: 'Dinheiro')
      pix = PaymentMethod.create!(name: 'Pix')
      buffet = Buffet.create!(brand_name: 'Miniland', corporate_name: 'Miniland LTDA',
                              registration_code: '00556164220103', phone_number: '(11)32441110', email: 'miniland@email.com',
                              address: 'Av Martins, 50', neighborhood: 'Jardim do Sol', city: 'Sales', state: 'SP',
                              postal_code: '14770-070', description: 'Buffet especializado em festas temáticas',
                              owner: owner, payment_methods: [cash, pix])
      event = EventType.create!(name: 'Festa dos Heróis', description: 'Festa infantil com temática de heróis',
                                min_guests: 10, max_guests: 80, duration: 240,
                                menu_details: 'Doces, Salgados, Bebidas',
                                alcohol_option: false, decoration_option: true, parking_service_option: true,
                                location_option: true, buffet: buffet, base_price: 5000.0, extra_guest: 100.0,
                                extra_hour: 500.0, we_base_price: 8000.0, we_extra_guest: 200.0, we_extra_hour: 800.0)
      order = Order.create!(client: client, buffet: buffet, event_type: event, event_date: 1.week.from_now,
                            estimated_guests: 30, event_details: 'Festa de aniversário', event_address: 'Rua das Flores')
      original_code = order.code

      order.update!(event_date: 1.month.from_now)

      expect(order.code).to eq original_code
    end
  end
end
