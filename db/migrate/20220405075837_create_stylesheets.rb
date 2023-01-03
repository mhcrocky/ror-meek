class CreateStylesheets < ActiveRecord::Migration[7.0]
  def change
    create_table :stylesheets do |t|
      t.string :name
      t.text :body

      t.timestamps null: false
    end
  end
end
