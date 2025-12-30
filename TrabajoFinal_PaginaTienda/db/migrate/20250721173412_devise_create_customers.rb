rails generate migration AddFieldsToCustomers username:string address:string phone:integerclass DeviseCreateCustomers < ActiveRecord::Migration[8.0]
  def change
    create_table :customers do |t|
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      t.datetime :remember_created_at

      t.timestamps null: false
    end

    add_index :customers, :email,                unique: true
    add_index :customers, :reset_password_token, unique: true
  end
end