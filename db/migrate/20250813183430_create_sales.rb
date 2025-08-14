class CreateSales < ActiveRecord::Migration[8.1]
  def change
    create_table :sales do |t|
      t.date :sale_date
      t.decimal :total_value
      t.string :payment_method
      t.integer :id_seller
      t.integer :id_buyer

      t.timestamps
    end
  end
end
