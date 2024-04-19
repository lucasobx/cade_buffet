class RenamePostaCodeToPostalCodeInBuffets < ActiveRecord::Migration[7.1]
  def change
    rename_column :buffets, :posta_code, :postal_code
  end
end
