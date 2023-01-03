class AddOrderToFooters < ActiveRecord::Migration[7.0]
  def change
    add_column :footers, :position, :integer
  end
end
