class CreateLandingPages < ActiveRecord::Migration[7.0]
  def change
    create_table :landing_pages do |t|
      t.string :name
      t.string :title
      t.text :content
      t.string :slug

      t.timestamps null: false
    end
    add_index :landing_pages, :slug, unique: true
  end
end
