class Comment < ActiveRecord::Base
  belongs_to :hotel

  def self.find_hotels_comments(hotels)
    comments = []
    hotels.each {|hotel| cm = hotel.comments.select(:content).take; comments.push[hotel.name,cm.content] if cm}
    comments
  end
end
