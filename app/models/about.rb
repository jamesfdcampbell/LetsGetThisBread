class About < ApplicationRecord
    def self.ransackable_attributes(auth_object = nil)
        %w[content]
        end
end
