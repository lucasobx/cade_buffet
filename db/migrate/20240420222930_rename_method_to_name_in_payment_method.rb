class RenameMethodToNameInPaymentMethod < ActiveRecord::Migration[7.1]
  def change
    rename_column :payment_methods, :method, :name
  end
end
