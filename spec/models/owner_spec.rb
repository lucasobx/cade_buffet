require 'rails_helper'

RSpec.describe Owner, type: :model do
  describe '#description' do
    it 'exibe o nome e o email' do
      owner = Owner.new(name: 'Jorge', email: 'jorge@email.com')

      expect(owner.description).to eq 'Jorge - jorge@email.com'
    end
  end

  describe '#valid?' do
    it 'retorna falso quando o nome está vazio' do
      owner = Owner.new(name: '', email: 'jorge@email.com', password: '12345678')

      expect(owner.valid?).to be false
    end
  end
end
