class AddCorrectStopedAt < ActiveRecord::Migration[7.0]
  def up
    remove_column :plays, :duration
    remove_column :plays, :stopped_at

    add_column :plays, :stopped_at, :integer, default: 0, null: false
  end

  def down
    remove_column :plays, :stopped_at

    add_column :plays, :duration, :integer
    add_column :plays, :stopped_at, :datetime
  end
end
