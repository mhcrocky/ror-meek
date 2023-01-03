ActiveAdmin.register Podcast do
  permit_params :id, :category_id, :description, :feed_url, :secondary_feed_url, :h1, :image, :meta_title, :name, :short_description, :slug,
                :wallpaper, :website, :noindex, :meta_description, :video_youtube_feed, :video_vimeo_feed, :video_rss_feed, :autopublish_new,
                :autopublish_old, :autopublish_old_date, :schema, :create_transcription, :transcript_only_new, :tags, :private

  menu parent: 'Media'

  filter :category, as: :select, collection: -> {Category.where(kind: Category.kinds[:podcast])}
  filter :name

  action_item :launch_feeder, only: :show do
    link_to 'Launch Podcast Episode feeder', launch_feeder_admin_podcast_path(resource), method: :put
  end

  member_action :launch_feeder, method: :put do
    PodcastEpisodeFeeder.import!(resource.id)

    redirect_to admin_podcast_path(resource), notice: 'Feed is uploaded.'
  end

  controller do
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end

    def update
      # Check It: Update All
      find_resource.episodes.each {|e| e.update_attribute(:noindex, params[:podcast][:noindex])} if change_noindex?
      super
    end

    private

    def change_noindex?
      (find_resource.noindex && params[:podcast][:noindex].to_i == 0) ||
          (!find_resource.noindex && params[:podcast][:noindex].to_i == 1)
    end
  end

  index do
    column :id
    column :name
    column :category
    column :feed_is_broken
    column 'Logo' do |podcast|
      podcast.image.exists? ? image_tag(podcast.normal_path) : 'MISSING IMAGE'
    end

    actions
  end

  show do |podcast|
    panel 'Podcast details' do
      attributes_table_for podcast do
        row :id
        row :name
        row :category_id
        row :description
        row :short_description
        row :website
        row :feed_url
        row :video_youtube_feed
        row :video_vimeo_feed
        row :video_rss_feed
        row :secondary_feed_url
        row :feed_is_broken
        row 'Image File Name' do
          podcast.image.name
        end
        row 'Image Content Type' do
          podcast.image.content_type
        end
        row 'Image File Size' do
          podcast.image.size
        end
        row 'Wallpaper File Name' do
          podcast.wallpaper.name
        end
        row 'Wallpaper Content Type' do
          podcast.wallpaper.content_type
        end
        row 'Wallpaper File Size' do
          podcast.wallpaper.size
        end
        row :tags
        row :private
      end
    end

    panel 'Podcast Publishing' do
      attributes_table_for podcast do
        row :autopublish_new
        row :autopublish_old, 'data-autopublish_old': podcast.autopublish_old
        row 'Autopublish old start date:' do
          podcast.autopublish_old_start_date
        end
      end
    end

    panel 'Podcast SEO' do
      attributes_table_for podcast do
        row :meta_title
        row :meta_description
        row :h1
        row :slug
        row :noindex
        row :schema
      end
    end

    panel 'Podcast transcriptions' do
      attributes_table_for podcast do
        row :create_transcription
        row :transcript_only_new
      end
    end

    render 'old_publih_scripts'
  end

  form multipart: true do |f|
    f.inputs 'General' do
      f.input :name
      f.input :category, as: :select, include_blank: false, collection: Category.where(kind: Category.kinds[:podcast])
      f.input :feed_url
      f.input :secondary_feed_url
      f.input :video_youtube_feed, hint: 'https://www.youtube.com/user/therocksandiego | https://www.youtube.com/channel/UC3tTp5PIzx6wCme937tj98Q'
      f.input :video_vimeo_feed, hint: 'https://vimeo.com/example'
      f.input :video_rss_feed, hint: 'http://www.nasa.gov/rss/dyn/TWAN_vodcast.rss'
      f.input :website
      f.input :description, as: :trumbowyg, input_html: PASS_DIV
      f.input :short_description
      f.input :image, hint: (f.object.image.exists? ? image_tag(f.object.normal_path) : 'No Image'), label: 'Logo'
      f.input :wallpaper, hint: (f.object.wallpaper.exists? ? image_tag(f.object.wallpaper_path) : 'No Image'), label: 'WallPaper Image'
      f.input :tags
      f.input :private
    end

    f.inputs 'Publishing' do
      f.input :autopublish_new, label: 'Autopublish New Episodes', hint: "Will autopublish new episodes with publishe date: `Today - 24 hours`"
      f.input :autopublish_old, label: 'Autopublish Old Episodes', hint: 'Will autopublish old episodes according to specified date'

      f.input :autopublish_old_date, as: :datepicker, input_html: {value: f.object.autopublish_old_start_date}
    end

    f.inputs 'SEO' do
      f.input :meta_title
      f.input :meta_description
      f.input :h1
      f.input :slug
      f.input :noindex
      f.input :schema
    end

    f.inputs 'Transcriptions' do
      f.input :create_transcription
      f.input :transcript_only_new
    end

    f.actions

    render 'old_publih_scripts'
  end
end
