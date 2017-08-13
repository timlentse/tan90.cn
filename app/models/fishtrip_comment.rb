class FishtripComment < ActiveRecord::Base
  belongs_to :fishtrip_hotel

  def self.find_hotels_comments(hotels)
    comments = []
    hotels.each { |hotel| comments.push([hotel.name, hotel.comments.first.content]) unless hotel.comments.empty? }
    comments
  end
end
