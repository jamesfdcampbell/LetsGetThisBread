class PagesController < ApplicationController
  def about
  end

  def orderconfirmation
    # Initialize @cart from session or set it to an empty array if session[:cart] is nil
    session_cart = session[:cart] || []
    
    # Map session_cart to @cart with enriched product details
    @cart = session_cart.map do |item|
      product = Product.find_by(id: item[0]) # find_by ensures nil is returned if no record is found
      if product
        {
          name: product.name,
          price: product.price,
          quantity: item[2],
          total_price: product.price * item[2]
        }
      else
        nil # If product is not found, return nil and handle it accordingly
      end
    end.compact # Remove nil entries from @cart in case any products are not found
  end
end
