class AddSchemaToPodcasts < ActiveRecord::Migration[7.0]
  def change
    add_column :podcasts, :schema, :text
  end
end
