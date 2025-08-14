class CreateAnimalDiets < ActiveRecord::Migration[8.1]
  def change
    create_table :animal_diets do |t|
      t.integer :id_animal
      t.integer :id_diet
      t.date :date_beginning
      t.date :date_end
      t.decimal :daily_quantity

      t.timestamps
    end
  end
end
