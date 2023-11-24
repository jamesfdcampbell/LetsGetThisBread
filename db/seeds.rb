require 'smarter_csv'

Product.destroy_all

products_csv_path = Rails.root.join('db', 'products.csv')

# Options for SmarterCSV - adapt these as needed
options = {
  remove_unmapped_keys: true, # Remove data that doesn't have a corresponding column
  downcase_header: true, # Useful if your CSV headers are not already downcased
  convert_values_to_numeric: false # Only use this if you want to auto-convert numeric values
}

SmarterCSV.process(products_csv_path, options).each do |product_hash|
  Product.create!(product_hash)
end
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?