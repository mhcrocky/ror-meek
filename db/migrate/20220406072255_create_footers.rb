class CreateFooters < ActiveRecord::Migration[7.0]
  def change
    create_table :footers do |t|
      t.string :title
      t.string :link

      t.timestamps null: false
    end
  end
end
