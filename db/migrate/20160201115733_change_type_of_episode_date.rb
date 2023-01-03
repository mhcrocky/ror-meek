class ChangeTypeOfEpisodeDate < ActiveRecord::Migration[7.0]
  def up
    change_column :episodes, :release_date, :date
  end

  def down
    change_column :episodes, :release_date, :datetime
  end
end
