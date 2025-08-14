class CreateMedicines < ActiveRecord::Migration[8.1]
  def change
    create_table :medicines do |t|
      t.string :name
      t.string :manufacturer
      t.string :dosage
      t.string :type
      t.decimal :cost

      t.timestamps
    end
  end
end
