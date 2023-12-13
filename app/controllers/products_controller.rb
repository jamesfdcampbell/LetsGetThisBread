class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
  before_action :initialize_session

  # GET /products or /products.json
  def index
    @products = Product.all
  end

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  def search
    # Begin with a scope that includes all products
    scope = Product.all
  
    # Filter by category if provided
    scope = scope.where(category: params[:category]) if params[:category].present? && params[:category] != 'All Categories'
  
    # Filter by keywords if provided
    if params[:keywords].present?
      keyword_search = "%#{params[:keywords]}%"
      scope = scope.where('name LIKE :search OR description LIKE :search', search: keyword_search)
    end
  
    # Assign the search results to @products instance variable
    @products = scope
  end 
  
  def initialize_session
    session[:cart] ||= []
end

  # Cart functionality
  def add_to_cart
    id = params[:id].to_i
    price = params[:price].to_f
    quantity = params[:quantity].to_i

    product = Product.find(id)

    existing_item = session[:cart].find { |item| item[0] == id }

    if existing_item
      existing_item[2] += quantity
      flash[:notice] = "#{product.name} quantity updated."
    else
      session[:cart] << [id, price, quantity]
      flash[:notice] = "#{product.name} added to cart."
    end

    redirect_to root_path
  end


  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to product_url(@product), notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to product_url(@product), notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy!

    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  end
  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:name, :description, :category, :price)
  end