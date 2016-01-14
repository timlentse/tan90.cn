class Comment < ActiveRecord::Base
  belongs_to :hotel

  def self.find_hotels_comments(hotels)
    hotels.map {|hotel| cm = hotel.comments.select(:content).take; [hotel.name,cm.content] if cm}
  end
end
