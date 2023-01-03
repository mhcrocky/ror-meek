class CreateShareQueue < ActiveRecord::Migration[7.0]
  def change
    create_table :share_queues do |t|
      t.integer  :episode_id
      t.datetime :published_at

      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
    end
  end
end
