require 'smarter_csv'

Product.destroy_all
Province.delete_all

products_csv_path = Rails.root.join('db', 'products.csv')

About.create(content: "Let's Get This BREAD is a charming local bakery dedicated to creating the finest baked goods. With local business booming, the team has decided to expand operations and create an online store so delicious baked goods can be delivered right to your doorstep. With a team of 30 skilled professionals, Let's Get This BREAD Bakery is committed to delivering top-notch baked goods and exceptional service. Established in 1993, our 30 years in the industry reflects our dedication to quality goods. We are excited to launch our online store and showcase our artisanal creations, like the soft, cloud-like croissants and our signature, fan-favourite butter tarts. While our physical store has been our main hub, we are expanding online to better serve customers seeking convenience without compromising our signature taste. Our platform is tailored for diverse audiences -- dessert enthusiasts, busy professionals, and those celebrating special moments. Let's Get This BREAD Bakery online is your go-to for handcrafted delights delivered directly to your doorstep.")

provinces = [
  { name: 'Manitoba', tax_rate: 0.12 },
  { name: 'Ontario', tax_rate: 0.13 },
  { name: 'New Brunswick', tax_rate: 0.15 },
  { name: 'Nova Scotia', tax_rate: 0.15 },
  { name: 'British Columbia', tax_rate: 0.12 },
  { name: 'Alberta', tax_rate: 0.05 },
  { name: 'Newfoundland and Labrador', tax_rate: 0.15 },
  { name: 'Prince Edward Island', tax_rate: 0.15 },
  { name: 'Quebec', tax_rate: 0.14975 },
  { name: 'Saskatchewan', tax_rate: 0.11 },
  { name: 'Yukon', tax_rate: 0.05 },
  { name: 'Northwest Territories', tax_rate: 0.05 },
  { name: 'Nunavut', tax_rate: 0.05 }
]

Province.create(provinces)


options = {
  remove_unmapped_keys: true,
  downcase_header: true,
  convert_values_to_numeric: false
}

SmarterCSV.process(products_csv_path, options).each do |product_hash|
  Product.create!(product_hash)
end
# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?