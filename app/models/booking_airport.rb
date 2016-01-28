class BookingAirport < ActiveRecord::Base

  def self.airports(city_en, lang)
    airports = []
    self.where(:city=>city_en).find_each do |airport|
      if lang=="cn"
        next if airport.name_cn.empty? 
        a_text = "#{airport.name_cn}附近酒店"
      else
        a_text = airport.name.include?("Airport") ? airport.name : "#{airport.name} Airport"
      end
      airports.push({:text=>a_text,:url=>"/booking/airport/#{airport.iata.downcase}/"})
    end
    airports
  end

end
