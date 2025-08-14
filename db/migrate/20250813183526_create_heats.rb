class CreateHeats < ActiveRecord::Migration[8.1]
  def change
    create_table :heats do |t|
      t.integer :id_animal
      t.date :date_heat
      t.text :observation

      t.timestamps
    end
  end
end
