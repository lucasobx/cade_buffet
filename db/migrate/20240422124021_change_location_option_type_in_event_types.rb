class ChangeLocationOptionTypeInEventTypes < ActiveRecord::Migration[7.1]
  def change
    change_column :event_types, :location_option, :boolean
  end
end
