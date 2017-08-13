class BookingAirport < ActiveRecord::Base
  belongs_to :booking_city

  def ahotels
    JSON.parse(hotels)
  end
end
