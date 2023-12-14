ActiveAdmin.register Order do
  # # Set up the menu if needed
  # menu priority: 5

  # Permit parameters for updating order state
  permit_params :state

  # Customizing the index page
  index do
    selectable_column
    id_column
    column :customer_name do |order|
      order.customer.name
    end
    column :date
    column :subtotal
    column :tax_rate
    column :total_with_tax
    column :state
    actions
  end

  # Customizing the form for editing the order state
  form do |f|
    f.inputs 'Order Details' do
      f.input :state, as: :select, collection: Order.states.keys
    end
    f.actions
  end

  # Customizing the show page
  show do
    attributes_table do
      row :customer_name do |order|
        order.customer.name
      end
      row :date
      row :subtotal
      row :tax_rate
      row :total_with_tax
      row :state
    end

    panel 'Products in Order' do
      table_for order.order_products.includes(:product) do
        column :product_name do |order_product|
          order_product.product.name
        end
        column :quantity
        column :priceAtTimeOfOrder
      end
    end
  end

  # Customizing the filters
  filter :customer_name, as: :string
  filter :date
  filter :state, as: :select, collection: -> { Order.states.keys }
end
