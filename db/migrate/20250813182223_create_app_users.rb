class CreateAppUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :app_users do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :cpf_cnpj
      t.string :address
      t.string :password_digest

      t.timestamps
    end
    add_index :app_users, :email, unique: true
    add_index :app_users, :cpf_cnpj, unique: true
  end
end
