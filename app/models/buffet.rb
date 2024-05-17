class Buffet < ApplicationRecord
  belongs_to :owner
  has_many :buffet_payment_methods
  has_many :payment_methods, through: :buffet_payment_methods
  has_many :event_types
  has_many :orders

  validates :brand_name, :corporate_name, :registration_code, :phone_number,
            :email, :address, :neighborhood, :city, :state, :postal_code,
            :description, :payment_methods, presence: true       
  validates :registration_code, uniqueness: true
  validate :unique_buffet_per_owner

  def full_address
    "#{address} - #{neighborhood}, #{city} - #{state}"
  end

  private

  def unique_buffet_per_owner
    if owner && Buffet.where(owner: owner).where.not(id: id).exists?
      errors.add(:owner, 'já possui um buffet cadastrado.')
    end
  end
end