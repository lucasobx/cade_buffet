class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :client, null: false, foreign_key: true
      t.references :buffet, null: false, foreign_key: true
      t.references :event_type, null: false, foreign_key: true
      t.date :event_date
      t.integer :estimated_guests
      t.text :event_details
      t.string :code
      t.string :event_address
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
