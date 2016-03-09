class FishtripComment < ActiveRecord::Base
  belongs_to :fishtrip_hotel

  def self.find_hotels_comments(hotels)
    comments = []
    hotels.each {|hotel| cm = hotel.fishtrip_comments.select(:content).take; comments.push([hotel.name,cm.content]) if cm}
    comments
  end

end
