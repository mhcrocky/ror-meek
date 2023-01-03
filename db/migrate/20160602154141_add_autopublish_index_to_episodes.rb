class AddAutopublishIndexToEpisodes < ActiveRecord::Migration[7.0]
  def change
    add_column :episodes, :autopublish_index, :integer, default: 0, null: false
  end
end
