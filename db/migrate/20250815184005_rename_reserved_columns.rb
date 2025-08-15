class RenameReservedColumns < ActiveRecord::Migration[8.1]
  def change
     rename_column :medicines, :type, :medicine_type
     rename_column :animals, :lot_id, :id_lot
  end
end
