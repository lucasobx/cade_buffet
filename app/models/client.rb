class Client < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders

  validates :name, :personal_code, presence: true
  validates :personal_code, length: { is: 11 }
  validates :personal_code, uniqueness: true
  validate :personal_code_must_be_numeric

  def description
    "#{name} - #{email}"
  end

  private

  def personal_code_must_be_numeric
    errors.add(:personal_code, 'deve ser numérico') unless personal_code.match?(/\A[0-9]+\z/)
  end
end
