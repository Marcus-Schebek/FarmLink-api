class CreateAnimals < ActiveRecord::Migration[8.1]
  def change
    create_table :animals do |t|
      t.string :ear_tag
      t.string :breed
      t.string :sex
      t.date :birth_date
      t.decimal :current_weight
      t.string :status
      t.string :production_objective
      t.references :lot, null: false, foreign_key: true
      t.integer :id_owner

      t.timestamps
    end
    add_index :animals, :ear_tag, unique: true
  end
end
