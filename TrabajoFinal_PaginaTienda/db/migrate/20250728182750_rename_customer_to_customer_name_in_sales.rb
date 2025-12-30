class RenameCustomerToCustomerNameInSales < ActiveRecord::Migration[8.0]
  def change
    rename_column :sales, :customer, :customer_name
  end
end
