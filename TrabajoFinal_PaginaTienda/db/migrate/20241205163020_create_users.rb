class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :name, limit: 100, null: false
      t.string :username, limit: 50, null: false
      t.string :mail, limit: 255, null: false
      t.integer :phone, null: false
      t.string :password_digest, limit: 255, null: false
      t.boolean :state, null: false
      t.date :entrydate, null: false
      t.integer :role_id, null: false

      t.timestamps
    end
    add_index :username, :mail, unique: true
    add_foreign_key :users, :roles
  end
end
