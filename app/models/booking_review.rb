class BookingReview < ActiveRecord::Base

  belongs_to :booking_hotel

  def self.find_comments(hotels)
    comments={}
    hotels.each do |hotel|
      comment = hotel.booking_reviews.select(:good).where("good!=''").take
    end
    comments
  end

  def self.find_6_reviews(hotels)
    comments={}
    hotels.each do |hotel|
      comment = hotel.booking_reviews.where("(good!='' or bad!='') and lang=1").pluck(:good,:bad,:author,:comment_time,:score).take(6)
      comments[hotel.id] = comment unless comment.empty?
    end
    comments
  end

end
