class OrderProductsController < ApplicationController
  before_action :set_order_product, only: %i[ show edit update destroy ]
  before_action :set_order

def create
  product = Product.find(order_product_params[:product_id])
  quantity = order_product_params[:quantity].to_i

  # Check if the product is already in the order
  order_product = @order.order_products.find_by(product_id: product.id)

  if order_product
    # If present, update the quantity
    order_product.update(quantity: order_product.quantity + quantity)
  else
    # If not present, create a new order_product
    @order.order_products.create(product: product, quantity: quantity)
  end

  redirect_to order_path(@order), notice: 'Product added to order successfully.'
end

  # PATCH/PUT /order_products/1 or /order_products/1.json
  def update
    respond_to do |format|
      if @order_product.update(order_product_params)
        format.html { redirect_to order_product_url(@order_product), notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @order_product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /order_products/1 or /order_products/1.json
  def destroy
    @order_product.destroy!

    respond_to do |format|
      format.html { redirect_to order_products_url, notice: "Product was successfully removed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_product
      @order_product = OrderProduct.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_product_params
      params.require(:order_product).permit(:order_id, :product_id, :quantity, :priceAtTimeOfOrder)
    end
end
