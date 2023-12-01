class AddForeignKeyForProvince < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :customers, :provinces, column: :province_id, primary_key: :id
  end
end
