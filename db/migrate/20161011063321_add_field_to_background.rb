class AddFieldToBackground < ActiveRecord::Migration[7.0]
  def change
    add_column :backgrounds, :background_slider_header, :text
  end
end
