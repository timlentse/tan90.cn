class BookingAirport < ActiveRecord::Base

  def self.airports(city_en)
    airports = []
    self.where(:city=>city_en).find_each do |airport|
      next if airport.name_cn.empty? 
      airports.push({:text=>airport.name_cn,:url=>"/booking/airport/#{airport.iata.downcase}/"})
    end
    airports
  end

end
