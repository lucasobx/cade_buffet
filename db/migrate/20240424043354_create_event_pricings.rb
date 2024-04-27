class CreateEventPricings < ActiveRecord::Migration[7.1]
  def change
    create_table :event_pricings do |t|
      t.references :event_type, null: false, foreign_key: true
      t.references :owner, null: false, foreign_key: true
      t.integer :day_type
      t.integer :min_people
      t.decimal :base_price
      t.decimal :extra_price
      t.decimal :overtime_rate

      t.timestamps
    end
  end
end
