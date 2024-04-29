class RenamePersonalIdToPersonalCodeInClients < ActiveRecord::Migration[7.1]
  def change
    rename_column :clients, :personal_id, :personal_code
  end
end
