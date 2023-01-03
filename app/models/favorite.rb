class Favorite < ActiveRecord::Base
  belongs_to :favoritable, polymorphic: true
  belongs_to :user

  validates :favoritable_type, :favoritable_id, :user, presence: true
  validates :favoritable_id, uniqueness: { scope: [:user, :favoritable_type] }
end
