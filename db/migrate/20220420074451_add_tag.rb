class AddTag < ActiveRecord::Migration[7.0]
  def change
    add_column :podcasts, :tags, :string
    add_column :episodes, :tags, :string
  end
end
