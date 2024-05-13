class AddAdjustmentDetailsToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :extra_fee, :decimal
    add_column :orders, :discount, :decimal
    add_column :orders, :adjustment_description, :text
  end
end
