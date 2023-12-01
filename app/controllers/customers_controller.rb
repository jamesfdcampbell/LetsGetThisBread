class CustomersController < ApplicationController
    before_action :set_customer, only: %i[show edit update destroy]
  
    def index
      @customers = Customer.all
    end
  
    def show
    end
  
    def new
      @customer = Customer.new
    end
  
    def create
      @customer = Customer.new(customer_params)
      if @customer.save
        # Handle a successful save.
      else
        render :new
      end
    end
  
    def edit
    end
  
    def update
      if @customer.update(customer_params)
        # Handle a successful update.
      else
        render :edit
      end
    end
  
    def destroy
      @customer.destroy
      # Handle the customer deletion.
    end
  
    private
  
    def set_customer
      @customer = Customer.find(params[:id])
    end
  
    def customer_params
      params.require(:customer).permit(:name, :email, :address, :province_id)
    end
  end
  