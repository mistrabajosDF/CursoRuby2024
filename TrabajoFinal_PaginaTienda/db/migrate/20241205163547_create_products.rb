class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :name, limit: 100, null: false
      t.string :description, limit: 500, null: false
      t.integer :stock, null: false
      t.float :price, null: false
      t.integer :talle
      t.string :color, limit: 50
      t.boolean :state, null: false, default: false
      t.integer :category_id, null: false

      t.timestamps
    end
    add_foreign_key :products, :categories
  end
end
