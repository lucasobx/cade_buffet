require 'rails_helper'

RSpec.describe Client, type: :model do
  describe '#description' do
    it 'exibe o nome e o email' do
      client = Client.new(name: 'Julia', email: 'julia@email.com')

      expect(client.description).to eq 'Julia - julia@email.com'
    end
  end

  describe '#valid?' do
    it 'retorna falso quando o nome está vazio' do
      client = Client.new(name: '', personal_code: '94641091064', email: 'julia@email.com', password: '12345678')

      expect(client.valid?).to be false
    end

    it 'retorna falso quando o CPF está vazio' do
      client = Client.new(name: 'Julia', personal_code: '', email: 'julia@email.com', password: '12345678')

      expect(client.valid?).to be false
    end

    it 'CPF deve ter 11 dígitos' do
      client = Client.new(name: 'Julia', personal_code: '9464109106', email: 'julia@email.com', password: '12345678')

      expect(client.valid?).to be false
    end

    it 'CPF deve ser único' do
      Client.create!(name: 'Julia', personal_code: '94641091060', email: 'julia@email.com', password: '12345678')
      s_client = Client.new(name: 'Pedro', personal_code: '94641091060', email: 'pedro@email.com', password: '12345678')

      expect(s_client.valid?).to be false
    end
  end
end
