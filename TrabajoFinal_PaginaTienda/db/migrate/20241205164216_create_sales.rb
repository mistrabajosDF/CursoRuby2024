class CreateSales < ActiveRecord::Migration[8.0]
  def change
    create_table :sales do |t|
      t.string :customer, limit: 100, null: false
      t.boolean :state, null: false, default: true
      t.integer :user_id, null: false
      t.float :total, null: false
      t.json :products, null: false, default: []

      t.timestamps
    end
    add_foreign_key :sales, :users
  end
end
