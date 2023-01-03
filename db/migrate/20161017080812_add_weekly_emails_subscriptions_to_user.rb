class AddWeeklyEmailsSubscriptionsToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :weekly_emails_subscriptions, :boolean, default: true, null: false
  end
end
