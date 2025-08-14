class CreateSaleAnimals < ActiveRecord::Migration[8.1]
  def change
    create_table :sale_animals do |t|
      t.integer :id_sale
      t.integer :id_animal

      t.timestamps
    end
  end
end
