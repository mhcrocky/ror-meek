class AddShareSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :share_schedules do |t|
      t.integer :hours, default: 0, null: false
      t.integer :minutes, default: 0, null: false
    end
  end
end
