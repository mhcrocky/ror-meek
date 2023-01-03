class Audit < ActiveRecord::Base
  belongs_to :user, class_name: 'User'

  validates :user, :ip, :action, presence: true
end
