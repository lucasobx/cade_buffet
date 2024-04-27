class Buffet < ApplicationRecord
  belongs_to :owner
  has_many :buffet_payment_methods
  has_many :payment_methods, through: :buffet_payment_methods
  has_many :event_types

  validates :brand_name, :corporate_name, :registration_code, :phone_number,
            :email, :address, :neighborhood, :city, :state, :postal_code,
            :description, :payment_methods, presence: true
            
  validates :registration_code, uniqueness: true 
end
