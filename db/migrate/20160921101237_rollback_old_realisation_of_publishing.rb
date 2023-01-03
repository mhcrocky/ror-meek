class RollbackOldRealisationOfPublishing < ActiveRecord::Migration[7.0]
  def up
    remove_column :episodes, :autopublish_index
    remove_column :episodes, :auto_published_at
    remove_column :episodes, :auto_published_as
    remove_column :episodes, :auto_publish_freequency_type

    remove_column :podcasts, :new_publish
    remove_column :podcasts, :new_publish_from_date
    remove_column :podcasts, :new_publish_frequency_type
    remove_column :podcasts, :new_publish_quantity

    remove_column :podcasts, :old_publish
    remove_column :podcasts, :old_publish_from_date
    remove_column :podcasts, :old_publish_frequency_type
    remove_column :podcasts, :old_publish_quantity
  end

  def down
    add_column :episodes, :autopublish_index, :integer, default: 0, null: false
    add_column :episodes, :auto_published_at, :datetime
    add_column :episodes, :auto_published_as, :string, default: '', null: false
    add_column :episodes, :auto_publish_freequency_type, :integer, default: 0, null: false

    add_column :podcasts, :new_publish, :boolean, default: false, null: false
    add_column :podcasts, :new_publish_from_date, :date
    add_column :podcasts, :new_publish_frequency_type, :integer, default: 1, null: false
    add_column :podcasts, :new_publish_quantity, :integer, default: 1, null: false

    add_column :podcasts, :old_publish, :boolean, default: false, null: false
    add_column :podcasts, :old_publish_from_date, :date
    add_column :podcasts, :old_publish_frequency_type, :integer, default: 1, null: false
    add_column :podcasts, :old_publish_quantity, :integer, default: 1, null: false
  end
end
