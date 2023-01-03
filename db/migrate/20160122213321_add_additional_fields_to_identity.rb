class AddAdditionalFieldsToIdentity < ActiveRecord::Migration[7.0]
  def up
    add_column :identities, :email, :string
    add_column :identities, :name, :string
  end

  def down
    remove_column :identities, :email
    remove_column :identities, :name
  end
end
