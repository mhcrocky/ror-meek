ActiveAdmin.register Podcast, as: 'broken_podcast' do
  permit_params :name, :feed_url, :website

  actions :show, :index, :edit, :update

  menu label: 'RSS'

  filter :category, as: :select, collection: -> {Category.where(kind: Category.kinds[:podcast])}
  filter :name

  controller do
    def scoped_collection
      Podcast.broken
    end

    def find_resource
      scoped_collection.friendly.find(params[:id])
    end


    def update
      super do |success, failure|
        success.html { redirect_to admin_broken_podcasts_path }
      end
    end
  end

  index do
    column :id
    column :name
    column :feed_url
    column :feed_is_broken

    actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :feed_url
      row :feed_is_broken
    end
  end


  form do |f|
    f.inputs 'RSS' do
      f.input :name
      f.input :feed_url
      f.input :website
    end

    f.actions
  end
end
