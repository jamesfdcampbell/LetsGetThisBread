class CheckoutController < ApplicationController
    def create

        session_cart = session[:cart] || []

        line_items = session_cart.map do |item|
            product = Product.find(item[0])

            {
                price_data: {
                currency: 'cad',
                product_data: {
                    name: product.name,
                    description: product.description
                },
                unit_amount: (product.price * 100).to_i # Stripe expects the amount in cents
                },
                quantity: item[2] # item[2] is the quantity
            }
        end

        @session = Stripe::Checkout::Session.create(
            payment_method_types: ['card'],
            line_items: line_items,
            mode: 'payment',
            success_url: checkout_success_url,
            cancel_url: checkout_cancel_url
        )
        
        respond_to do |format|
            format.js
         end

         # redirect_to @session.url, allow_other_host: true
    end

    def success
        @session = Stripe::Checkout::Session.retrieve(params[:session_id])
        @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
    end

    def cancel; end
end
