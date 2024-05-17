require 'rails_helper'

RSpec.describe Client, type: :model do
  describe '#description' do
    it 'exibe o nome e o email' do
      client = Client.new(name: 'Julia', email: 'julia@email.com')

      expect(client.description).to eq 'Julia - julia@email.com'
    end
  end

  describe '#valid?' do
    it 'nome é obrigatório' do
      client = Client.new(name: '', personal_code: '94641091064', email: 'julia@email.com', password: '12345678')

      client.valid?
      expect(client.errors.include? :name).to be true
    end

    it 'cpf é obrigatório' do
      client = Client.new(name: 'Julia', personal_code: '', email: 'julia@email.com', password: '12345678')

      client.valid?
      expect(client.errors.include? :personal_code).to be true
    end

    it 'cpf deve ser numérico' do
      client = Client.new(name: 'Julia', personal_code: '946BC091060', email: 'julia@email.com', password: '12345678')

      client.valid?
      expect(client.errors.include? :personal_code).to be true
    end

    it 'cpf não deve ter menos de 11 dígitos' do
      client = Client.new(name: 'Julia', personal_code: '9464109106', email: 'julia@email.com', password: '12345678')

      client.valid?
      expect(client.errors.include? :personal_code).to be true
    end

    it 'cpf não deve ter mais de 11 dígitos' do
      client = Client.new(name: 'Julia', personal_code: '946410910655', email: 'julia@email.com', password: '12345678')

      client.valid?
      expect(client.errors.include? :personal_code).to be true
    end

    it 'cpf deve ter 11 dígitos' do
      client = Client.new(name: 'Julia', personal_code: '94641091060', email: 'julia@email.com', password: '12345678')

      expect(client.valid?).to be true
    end

    it 'cpf deve ser único' do
      client1 = Client.create!(name: 'Julia', personal_code: '94641091060', email: 'julia@email.com', password: '12345678')
      client2 = Client.new(name: 'Pedro', personal_code: '94641091060', email: 'pedro@email.com', password: '12345678')

      expect(client2.valid?).to be false
    end
  end
end
