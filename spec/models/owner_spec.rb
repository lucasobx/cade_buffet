require 'rails_helper'

RSpec.describe Owner, type: :model do
  describe '#description' do
    it 'exibe o nome e o email' do
      owner = Owner.new(name: 'Jorge', email: 'jorge@email.com')

      expect(owner.description).to eq 'Jorge - jorge@email.com'
    end
  end
end
