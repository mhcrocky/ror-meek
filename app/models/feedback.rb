class Feedback < ActiveRecord::Base
  validates :name, :body, presence: true
  validates_format_of :email, with: Devise::email_regexp
end
