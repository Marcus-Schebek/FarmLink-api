class CreateDiets < ActiveRecord::Migration[8.1]
  def change
    create_table :diets do |t|
      t.string :aliment_type
      t.decimal :cost_kg
      t.text :nutrients

      t.timestamps
    end
  end
end
