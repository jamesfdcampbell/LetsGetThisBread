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

  # Static pages
  get '/about', to: 'pages#about'

  # Health check route
  get 'up', to: 'rails/health#show', as: :rails_health_check

  # Admin dashboard route
  get '/admin', to: 'admin#dashboard'

  # Root path of the application
  root to: 'products#index'
end