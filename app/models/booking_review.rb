class BookingReview < ActiveRecord::Base

  belongs_to :booking_hotel

  def self.find_comments(hotels)
    comments ={}
    hotels.each do |hotel|
      comment = hotel.booking_reviews.select(:good).where("good!=''").take
      comments[hotel.id] = comment.good if comment
    end
    comments
  end

end
