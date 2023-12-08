class OrderProduct < ApplicationRecord
  belongs_to :order
  belongs_to :product

  def total_price
    quantity * product.price
  end

  def to_stripe_line_item
    {
      name: product.name,
      description: product.description,
      amount: product.price_cents,
      currency: 'cad',
      quantity: quantity
    }
  end
end
