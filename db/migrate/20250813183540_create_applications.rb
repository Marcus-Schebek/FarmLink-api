class CreateApplications < ActiveRecord::Migration[8.1]
  def change
    create_table :applications do |t|
      t.date :application_date
      t.text :notes
      t.integer :id_animal
      t.integer :id_medicine

      t.timestamps
    end
  end
end
