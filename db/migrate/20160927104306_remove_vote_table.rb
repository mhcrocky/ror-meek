class RemoveVoteTable < ActiveRecord::Migration[7.0]
  def up
    remove_index :votes, name: 'index_votes_on_ratable_id_and_ratable_type'
    drop_table :votes
  end

  def down
    create_table "votes", force: true do |t|
      t.integer "score",        null: false
      t.integer "user_id",      null: false
      t.integer "ratable_id",   null: false
      t.string  "ratable_type", null: false
    end

    add_index "votes", ["ratable_id", "ratable_type"], name: "index_votes_on_ratable_id_and_ratable_type", using: :btree
  end
end
