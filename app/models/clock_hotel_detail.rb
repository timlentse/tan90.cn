class ClockHotelDetail < ActiveRecord::Base

  def self.parse_each_field(hotel_id)
    found = self.find_by(:hotel_id=>hotel_id)
    return unless found
    hotel_detail = {}
    [:room_json,:desc_json,:comment_json].each do |md|
      hotel_detail[md] = JSON.parse(found[md])
    end
    hotel_detail
  end

  def self.find_rooms(hotels)
    rooms = {}
    hotels.each do |hotel| 
      found = self.find_by(hotel_id: hotel.id)
      rooms[hotel.elong_id] = JSON.parse(found.room_json)
    end
    rooms
  end
end
