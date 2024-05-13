class Order < ApplicationRecord
  belongs_to :client
  belongs_to :buffet
  belongs_to :event_type
  belongs_to :payment_method, optional: true

  enum status: { pending: 0, approved: 5, confirmed: 7, canceled: 9}

  validates :code, :event_date, :estimated_guests, presence: true
  validate :event_date_is_future

  before_validation :generate_code, on: :create
  before_save :calculate_final_price

  def calculate_final_price
    base_guests = event_type.min_guests
    if event_date.on_weekend?
      base_price = event_type.we_base_price
      extra_guest_price = event_type.we_extra_guest
    else
      base_price = event_type.base_price
      extra_guest_price = event_type.extra_guest
    end

    if estimated_guests > base_guests
      extra_guests = estimated_guests - base_guests
      self.final_price = base_price + (extra_guests * extra_guest_price)
    else
      self.final_price = base_price
    end

    self.final_price += extra_fee.to_f - discount.to_f
  end

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end

  def event_date_is_future
    if self.event_date.present? && self.event_date <= Date.today
      self.errors.add :event_date, "deve ser futura."
    end    
  end
end
