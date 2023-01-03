class UpdateUserEmailIndex < ActiveRecord::Migration[7.0]
  def up
    remove_index :users, name: 'index_users_on_email'
    add_index :users, ["email"], name: "index_users_on_email", using: :btree
  end

  def down
    remove_index :users, name: 'index_users_on_email'
    add_index :users, ["email"], name: "index_users_on_email", unique: true, using: :btree
  end
end
