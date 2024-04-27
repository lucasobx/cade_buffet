class DropEventPricings < ActiveRecord::Migration[7.1]
  def change
    drop_table :event_pricings
  end
end
