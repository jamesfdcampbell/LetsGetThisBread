class Order < ApplicationRecord
  has_many :order_products, dependent: :destroy
  has_many :products, through: :order_products
  belongs_to :customer

  enum state: { in_cart: 0, placed: 1, paid: 2, cancelled: 3 }

  validates :customer_id, presence: true
  validates :date, presence: true
  validates :state, presence: true, inclusion: { in: %w(in_cart placed paid cancelled) }

  def self.ransackable_attributes(auth_object = nil)
    %w[id date state subtotal tax_rate total_with_tax] + _ransackers.keys
  end

  def self.ransackable_associations(auth_object = nil)
    %w[customer order_products]
  end


  def total_price
    order_products.sum(&:total_price)
  end
end
