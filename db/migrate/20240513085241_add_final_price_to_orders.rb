class AddFinalPriceToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :final_price, :decimal
    add_column :orders, :price_valid_until, :date
  end
end
