class AddCustomerToSales < ActiveRecord::Migration[7.0]
  def change
    add_reference :sales, :customer, foreign_key: true
  end
end