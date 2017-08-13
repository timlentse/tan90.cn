desc 'sss'
task :ss => :environment do
  FishtripHotel.find_each do |hotel|
    rooms = JSON.parse(hotel.rooms)
    rooms.each do |room|
      price = room['price'][/\d+/]
      FishtripRoom.create(hotel_id: hotel.id, info: room['info'], price: price)
    end
  end
end
