class Province < ApplicationRecord
    has_many :customers

    validates :name, :tax_rate, presence: true
    validates_numericality_of :tax_rate, :decimal => true

    def self.ransackable_attributes(auth_object = nil)
        ['name', 'tax_rate']
    end
end
