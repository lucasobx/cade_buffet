class Buffet < ApplicationRecord
  belongs_to :owner
  has_many :buffet_payment_methods
  has_many :payment_methods, through: :buffet_payment_methods
end
