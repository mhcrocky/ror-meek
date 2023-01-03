ActiveAdmin.register ShareQueue do
  menu parent: 'Share'

  config.filters = false
  config.batch_actions = false
  config.sort_order = 'id_asc'

  actions :index

  scope :without_publish_date, default: true
  scope :with_publish_date

  member_action :share, method: :put do

    if resource.publish_episode!
      flash[:notice] = 'Shared!'
    else
      flash[:alert] = 'There is no episode.'
    end

    redirect_to action: :index
  end


  member_action :remove, method: :delete do
    resource.delete

    flash[:notice] = 'Record was deleted'
    redirect_to action: :index
  end


  index do
    column :id

    column 'Deleted' do |resource|
      status_tag !resource.episode.present?
    end

    column :episode do |resource|
      if resource.episode.present?
        link_to resource.episode_name, admin_episode_path(resource.episode_id)
      else
        resource.episode_name
      end
    end

    column :episode_release_date
    column :published_at

    column :publish_type do |resource|
      if resource.from_new?
        status_tag 'New Episode', :ok
      else
        status_tag 'Old Episodes', :yes
      end
    end

    actions defaults: false do |resource|
      if resource.episode.present?
        link_to 'Share Now!', share_admin_share_queue_path(resource), method: :put
      else
        link_to 'Delete', remove_admin_share_queue_path(resource), method: :delete
      end
    end
  end
end
