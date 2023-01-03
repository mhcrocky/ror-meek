ActiveAdmin.register Category do
  permit_params :id, :h1, :kind, :meta_title, :name, :position, :slug, :meta_description, :wallpaper

  filter :kind, as: :select, collection: Category.kinds.map{ |k,v| [k.humanize, v] }

  controller do
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end
  end

  index do
    column :id
    column :name
    column :position
    column :kind do |c|
      c.kind.humanize
    end
    actions
  end

  form multipart: true do |f|
    f.inputs 'General' do
      f.input :kind, as: :select, collection: Category.kinds.map{ |k,v| [k.humanize, k] }
      f.input :name
      f.input :position
      f.input :wallpaper, hint: (f.object.wallpaper.exists? ? image_tag(f.object.wallpaper_path) : 'No Image'), label: 'WallPaper Image'
    end

    f.inputs 'SEO' do
      f.input :meta_title
      f.input :meta_description
      f.input :h1
    end

    f.actions
  end

end
