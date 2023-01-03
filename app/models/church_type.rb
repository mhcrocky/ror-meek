class ChurchType < ActiveRecord::Base
  scope :ordered, -> { order(:name) }
end
