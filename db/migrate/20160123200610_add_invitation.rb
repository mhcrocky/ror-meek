class AddInvitation < ActiveRecord::Migration[7.0]
  def up
    create_table :invitations, force: true do |t|
      t.integer  :sender_id
      t.string   :recipient_email, null: false
      t.string   :token

      t.string   :subject,         null: false
      t.text     :message,         null: false

      t.timestamps null: false
    end

    add_column :users, :invitation_id, :integer
  end

  def down
    drop_table :invitations
    remove_column :users, :invitation_id
  end
end
