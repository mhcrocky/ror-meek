class Country < ActiveRecord::Base
  has_many :regions, class_name: 'Region'
end
