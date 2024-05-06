class Order < ApplicationRecord
  belongs_to :client
  belongs_to :buffet
  belongs_to :event_type

  enum status: { pending: 0, confirmed: 5, canceled: 9}

  validates :code, :event_date, :estimated_guests, presence: true
  validate :event_date_is_future

  before_validation :generate_code, on: :create

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
