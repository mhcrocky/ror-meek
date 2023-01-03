class RemoveIsOrganic < ActiveRecord::Migration[7.0]
  def up
    remove_column :plays, :is_organic
  end

  def down
    add_column :plays, :is_organic, :boolean
  end
end
