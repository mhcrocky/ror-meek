class AddPrivateToPodcast < ActiveRecord::Migration[7.0]
  def change
    add_column :podcasts, :private, :boolean, null: false, default: false
  end
end
