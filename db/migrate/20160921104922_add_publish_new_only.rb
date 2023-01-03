class AddPublishNewOnly < ActiveRecord::Migration[7.0]
  def change
    add_column :podcasts, :autopublish_new, :boolean, default: false, null: false
    add_column :podcasts, :autopublish_old, :boolean, default: false, null: false
    add_column :podcasts, :distance_in_days, :integer

    add_column :episodes, :already_shared, :boolean, default: false

    add_column :share_queues, :publish_type, :integer, default: 0, null: false
  end
end
