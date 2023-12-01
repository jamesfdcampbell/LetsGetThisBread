class Product < ApplicationRecord
    
    validates :name, :description, :category, :price, presence: true
    validates :price, numericality: true
    
    def self.ransackable_attributes(auth_object = nil)
        ['category', 'created_at', 'description', 'id', 'id_value', 'name', 'price', 'updated_at']
    end
end
