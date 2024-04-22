class CreateEventTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :event_types do |t|
      t.string :name
      t.text :description
      t.integer :min_guests
      t.integer :max_guests
      t.integer :duration
      t.text :menu_details
      t.boolean :alcohol_option
      t.boolean :decoration_option
      t.boolean :parking_service_option
      t.integer :location_option
      t.references :buffet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
