class AddFinalPriceDetailsToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :final_price, :decimal, precision: 10, scale: 2
    add_column :orders, :price_valid_until, :date
    add_column :orders, :extra_fee, :decimal, precision: 10, scale: 2
    add_column :orders, :discount, :decimal, precision: 10, scale: 2
    add_column :orders, :adjustment_description, :text
    add_reference :orders, :payment_method, null: true, foreign_key: true
  end
end
