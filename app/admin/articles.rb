ActiveAdmin.register Article do
    permit_params :id, :category_id, :description, :feed_url, :h1, :image, :meta_title, :name, :short_description, :slug,
    :wallpaper, :website, :noindex, :meta_description, :autopublish_new, :autopublish_old, :autopublish_old_date, :schema, :tags

  menu parent: 'Media'

  controller do
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end
  end

  after_save do
    if params[:article][:csv_file].present?
      dump = params[:article][:csv_file].path
      UploadInitialPostsService.initial_posts(dump, resource)
    end
  end

  index do
    column :id
    column :name
    column :category
    column :short_description

    actions
  end  

  form multipart: true do |f|
    f.inputs 'General' do
      f.input :name
      f.input :category, as: :select, include_blank: false, collection: Category.where(kind: Category.kinds[:article])
      f.input :feed_url
      f.input :description
      f.input :short_description
      f.input :image, hint: (f.object.image.exists? ? image_tag(f.object.normal_path) : 'No Image'), label: 'Logo'
      f.input :wallpaper, hint: (f.object.wallpaper.exists? ? image_tag(f.object.wallpaper_path) : 'No Image'), label: 'WallPaper Image'
      f.input :slug
      f.input :h1
      f.input :tags      
      f.input :csv_file, as: :file if !resource.posts.exists?
    end

    f.inputs 'SEO' do
      f.input :meta_title
      f.input :meta_description
      f.input :h1
      f.input :slug
      f.input :noindex
      f.input :schema
    end

    f.actions
  end
end
