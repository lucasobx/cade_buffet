class Client < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders

  validates :name, :personal_code, presence: true
  validates :personal_code, length: { is: 11 }
  validates :personal_code, uniqueness: true

  def description
    "#{name} - #{email}"
  end
end
