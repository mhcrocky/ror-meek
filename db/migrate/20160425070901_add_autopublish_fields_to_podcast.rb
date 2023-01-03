class AddAutopublishFieldsToPodcast < ActiveRecord::Migration[7.0]
  def change
    ## if podcast will publish newest episodes
    add_column :podcasts, :new_publish, :boolean, default: false, null: false
    add_column :podcasts, :new_publish_from_date, :date
    # freequensy type: 1=daily, 2-weekly, 3-monthly
    add_column :podcasts, :new_publish_freequency_type, :integer, default: 1, null: false
    add_column :podcasts, :new_publish_quantity, :integer, default: 1, null: false

    ## if podcast will publish old episodes
    add_column :podcasts, :old_publish, :boolean, default: false, null: false
    add_column :podcasts, :old_publish_from_date, :date
    # freequensy type: 1=daily, 2-weekly, 3-monthly
    add_column :podcasts, :old_publish_freequency_type, :integer, default: 1, null: false
    add_column :podcasts, :old_publish_quantity, :integer, default: 1, null: false

    # for podcasts, for which will be published newest and old episodes simultaneously - all added columns will be in use
  end
end
