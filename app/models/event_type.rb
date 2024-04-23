class EventType < ApplicationRecord
  belongs_to :buffet

  validates :name, :description, :min_guests, :max_guests,
            :duration, :menu_details, presence: true
end
