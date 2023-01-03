ActiveAdmin.register StaticPage do
  permit_params :id, :content, :name, :title

  actions :all, except: [:new, :create, :destroy]

  controller do
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end
  end

  index do
    column :name
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :title
      f.input :content, as: :trumbowyg, input_html: PASS_DIV
    end

    f.actions
  end
end
