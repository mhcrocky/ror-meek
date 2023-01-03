class AddLoggedInHeaderToBackgrounds < ActiveRecord::Migration[7.0]
  def change
    add_column :backgrounds, :logged_in_header, :text, default: '<div> </div>'
  end
end
