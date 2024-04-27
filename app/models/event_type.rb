class EventType < ApplicationRecord
  belongs_to :buffet

  validates :name, :description, :min_guests, :max_guests, :duration, :menu_details,
            :base_price, :extra_guest, :extra_hour, :we_base_price,
            :we_extra_guest, :we_extra_hour, presence: true
end
