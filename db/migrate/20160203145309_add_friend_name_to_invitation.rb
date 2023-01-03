class AddFriendNameToInvitation < ActiveRecord::Migration[7.0]
  def up
    add_column :invitations, :friend_name, :string, null: false
  end

  def down
    remove_column :invitations, :friend_name
  end
end
