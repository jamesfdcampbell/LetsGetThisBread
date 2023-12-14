Rails.application.routes.draw do
  # Devise routes for Customers
  devise_for :customers, controllers: { registrations: 'customers/registrations' }

  # Devise routes for Admin Users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Products routes
  resources :products do
    collection do
      get 'search' # adds a search action to the products resource
    end
  end

  resources :orders do
    resources :order_products, only: [:create, :update, :destroy]
  end

  # Other resources
  resources :order_products
  resources :orders
  
  # Stripe
  scope '/checkout' do
    post 'create', to: 'checkout#create', as: 'checkout_create'
    get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
    get 'success', to: 'checkout#success', as: 'checkout_success'
  end

  # Cart functionality
  post 'products/add_to_cart/:id', to: 'products#add_to_cart', as: 'add_to_cart'
  delete 'products/remove_from_cart/:id', to: 'products#remove_from_cart', as: 'remove_from_cart'
  post 'add_quantity/:id', to: 'products#increase_quantity', as: 'increase_quantity'
  post 'remove_quantity/:id', to: 'products#decrease_quantity', as: 'decrease_quantity'
  
  # Static pages
  get '/about', to: 'pages#about'
  get '/orderconfirmation', to: 'pages#orderconfirmation'

  # Health check route
  get 'up', to: 'rails/health#show', as: :rails_health_check

  # Admin dashboard route
  get '/admin', to: 'admin#dashboard'

  # Root path of the application
  root to: 'products#index'
end