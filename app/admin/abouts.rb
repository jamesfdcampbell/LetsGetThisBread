ActiveAdmin.register About do
  permit_params :content

  form do |f|
    f.inputs do
      f.input :content, as: :text
    end
    f.actions
  end

  show do
    attributes_table do
      row :content
    end
    active_admin_comments
  end
end
