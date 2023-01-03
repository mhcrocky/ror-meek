class AddFieldsToShareQueue < ActiveRecord::Migration[7.0]
  def up
    add_column :share_queues, :episode_name, :string
    add_column :share_queues, :episode_release_date, :date

    execute <<-SQL
      UPDATE share_queues
      SET episode_name = e.name, episode_release_date = e.release_date
      FROM episodes e
      WHERE share_queues.episode_id = e.id
    SQL

  end

  def down
    remove_column :share_queues, :episode_name
    remove_column :share_queues, :episode_release_date
  end
end
