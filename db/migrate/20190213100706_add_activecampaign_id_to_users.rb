class AddActivecampaignIdToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :activecampaign_id, :integer
  end
end
