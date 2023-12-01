class Province < ApplicationRecord
    has_many :customers

    def self.ransackable_attributes(auth_object = nil)
        ['name', 'tax_rate']
    end
end
