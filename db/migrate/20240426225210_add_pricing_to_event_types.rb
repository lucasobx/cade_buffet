class AddPricingToEventTypes < ActiveRecord::Migration[7.1]
  def change
    add_column :event_types, :base_price, :decimal, precision: 8, scale: 2
    add_column :event_types, :extra_guest, :decimal, precision: 8, scale: 2
    add_column :event_types, :extra_hour, :decimal, precision: 8, scale: 2
    add_column :event_types, :we_base_price, :decimal, precision: 8, scale: 2
    add_column :event_types, :we_extra_guest, :decimal, precision: 8, scale: 2
    add_column :event_types, :we_extra_hour, :decimal, precision: 8, scale: 2
  end
end
