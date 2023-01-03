ActiveAdmin.register Post do
  permit_params :id, :h1, :meta_title, :name, :article_id, :release_date, :slug, :stream_url, :noindex, :short_description, :schema,
                :body, :tags

  menu parent: 'Media'

  controller do
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end
  end

  index do
    column :id
    column :name
    column :tags
    column :release_date
    column :short_description

    actions
  end
end
