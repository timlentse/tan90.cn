class BookingHotel < ActiveRecord::Base
  belongs_to :city, primary_key: :full_name, foreign_key: :city_unique, class_name: 'BookingCity'
  has_many :reviews, foreign_key: :hotel_id, class_name: 'BookingReview'

  def self.find_hotels_by_ids(hotel_ids)
    self.includes(:reviews).where(id: hotel_ids)
  end

  def get_nearby_hotels
    hotel_ids = JSON.parse(self.nearby_hotels)
    self.class.select(:id,:name_cn,:address_cn,:minrate,:photo_url,:currencycode).where(id: hotel_ids).take(6)
  end
end
