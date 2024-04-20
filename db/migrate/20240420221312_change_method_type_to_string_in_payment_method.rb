class ChangeMethodTypeToStringInPaymentMethod < ActiveRecord::Migration[7.1]
  def up
    change_column :payment_methods, :method, :string
  end

  def down
    change_column :payment_methods, :method, :integer
  end
end
