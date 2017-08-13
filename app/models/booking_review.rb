class BookingReview < ActiveRecord::Base
  belongs_to :booking_hotel

  def self.find_comments(hotels, language)
    lang = language == 'cn' ? 0 : 1
    comments = {}
    hotels.each do |hotel|
      comment = hotel.reviews.select(:good, :author).where("good!='' and lang=?", lang).take
      comments[hotel.name_cn] = comment if comment
    end
    comments
  end

  def self.find_6_reviews(hotels, language)
    lang = language == 'cn' ? 0 : 1
    comments = {}
    hotels.each do |hotel|
      comment = hotel.reviews.where("(good!='' or bad!='') and lang=?",lang).pluck(:good,:bad,:author,:comment_time,:score).take(6)
      comments[hotel.id] = comment unless comment.empty?
    end
    comments
  end

  def self.find_comments_with_hotel(hotel, language)
    lang = language == 'cn' ? 0 : 1
    hotel.reviews.where("(good!='' or bad!='') and lang=?", lang).select(:good,:bad,:author,:comment_time,:score)
  end
end
