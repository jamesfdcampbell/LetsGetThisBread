class AddTotalsToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :subtotal, :decimal, precision: 10, scale: 2
    add_column :orders, :tax_rate, :decimal, precision: 5, scale: 2
    add_column :orders, :total_with_tax, :decimal, precision: 10, scale: 2
  end
end
