class ClearifyCategory < ActiveRecord::Migration[7.0]
  def up
    remove_column :categories, :parent_id
  end

  def down
    add_column :categories, :parent_id, :integer
  end
end
