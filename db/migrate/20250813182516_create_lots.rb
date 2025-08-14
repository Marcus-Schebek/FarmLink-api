class CreateLots < ActiveRecord::Migration[8.1]
  def change
    create_table :lots do |t|
      t.date :creation_date
      t.string :origin_location

      t.timestamps
    end
  end
end
