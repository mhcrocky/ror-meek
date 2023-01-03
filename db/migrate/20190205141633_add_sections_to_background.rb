class AddSectionsToBackground < ActiveRecord::Migration[7.0]
  def change
    add_column :backgrounds, :section_1, :text, default: '<div> </div>'
    add_column :backgrounds, :section_2, :text, default: '<div> </div>'
    add_column :backgrounds, :section_3, :text, default: '<div> </div>'
    add_column :backgrounds, :section_4, :text, default: '<div> </div>'
  end
end
