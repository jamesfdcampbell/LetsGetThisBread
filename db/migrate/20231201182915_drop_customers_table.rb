class DropCustomersTable < ActiveRecord::Migration[6.0]
  def up
    drop_table :customers
  end

  def down
    # Optionally, recreate the table in the down method if you want to make this reversible.
  end
end
