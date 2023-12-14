class Order < ApplicationRecord
  has_many :order_products
  has_many :products, through: :order_products
  belongs_to :customer

  enum state: { in_cart: 0, placed: 1, paid: 2, cancelled: 3 }

  validates :customer_id, presence: true
  validates :date, presence: true
  validates :state, presence: true, inclusion: { in: %w(in_cart placed paid cancelled) }

  def total_price
    order_products.sum(&:total_price)
  end
end
