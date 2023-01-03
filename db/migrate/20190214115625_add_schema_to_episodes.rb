class AddSchemaToEpisodes < ActiveRecord::Migration[7.0]
  def change
    add_column :episodes, :schema, :text
  end
end
