class UpdateDefaultValue < ActiveRecord::Migration[7.0]
  def up
    change_column :users, :facebook, :string, default: '', null: false
    change_column :users, :twitter, :string, default: '', null: false
    change_column :users, :linkedin, :string, default: '', null: false
    change_column :users, :church_name, :string, default: '', null: false
    change_column :users, :verse, :text, default: '', null: false

    change_column :users, :birth_date, :string, default: '', null: false
    change_column :users, :gender, :string, default: '', null: false
    change_column :users, :language, :string, default: '', null: false
  end

  def down
    change_column :users, :facebook, :string, default: nil
    change_column :users, :twitter, :string, default: nil
    change_column :users, :linkedin, :string, default: nil
    change_column :users, :church_name, :string, default: nil
    change_column :users, :verse, :text, default: nil

    change_column :users, :birth_date, :string, default: nil
    change_column :users, :gender, :string, default: nil
    change_column :users, :language, :string, default: nil
  end
end
