class RemoveAttachment < ActiveRecord::Migration[7.0]
  def up
    drop_table :attachments
  end

  def down

    create_table :attachments, force: true do |t|
      t.integer  :background_id
      t.string   :file_file_name
      t.string   :file_content_type
      t.integer  :file_file_size
      t.datetime :file_updated_at
      t.string   :type
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
    end

  end
end
