class FishtripCity < ActiveRecord::Base
  has_many :hotels, foreign_key: :city_id, class_name: 'FishtripHotel'
end
