class CreateSymptoms < ActiveRecord::Migration[8.1]
  def change
    create_table :symptoms do |t|
      t.integer :id_animal
      t.date :date_symptom
      t.text :description

      t.timestamps
    end
  end
end
