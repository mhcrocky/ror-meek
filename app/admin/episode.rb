ActiveAdmin.register Episode do
  permit_params :id, :h1, :meta_title, :name, :podcast_id, :release_date, :slug, :stream_url, :noindex, :video, :short_description, :schema,
                :transcription, :short_description, :tags

  menu parent: 'Media'

  config.sort_order = 'podcast_id_asc release_date_desc'

  filter :podcast, as: :select, label: 'podcast', collection: -> {Podcast.all.ordered}
  filter :name

  controller do
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end
  end

  member_action :share_particular_episode, method: :get do
    PublisherService.call(resource)

    redirect_to resource_path(resource), notice: 'Shared!'
  end

  action_item(:show, only: :show) do
    link_to 'Share Episode', share_particular_episode_admin_episode_path(resource)
  end

  index do
    column :id
    column :name
    column :podcast
    column :release_date
    column :video, hint: 'https://www.youtube.com/embed/yJ2OGIZbTPI'
    column :short_description
    column :already_shared
    actions
  end

  form do |f|
    f.inputs 'General' do
      f.input :podcast
      f.input :name
      f.input :release_date if f.object.new_record?
      f.input :stream_url
      f.input :video
      f.input :short_description
      f.input :transcription, as: :trumbowyg, input_html: PASS_DIV
      f.input :tags
    end

    f.inputs 'SEO' do
      f.input :meta_title
      f.input :h1
      f.input :noindex
      f.input :schema
    end

    f.actions
  end
end
