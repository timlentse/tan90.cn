class BookingCity < ActiveRecord::Base
  has_many :hotels, primary_key: :full_name, foreign_key: :city_unique, class_name: 'BookingHotel'
  has_many :airports, primary_key: :full_name, foreign_key: :city, class_name: 'BookingAirport'

  def seo_airports(lang='cn')
    airport_seo = []
    self.airports.each do |airport|
      if lang == 'cn'
        next if airport.name_cn.empty? 
        a_text = "#{airport.name_cn}附近酒店"
      else
        a_text = airport.name.include?('Airport') ? airport.name : "#{airport.name} Airport"
      end
      airport_seo.push({ text: a_text, url: "/booking/airport/#{airport.iata.downcase}/" })
    end
    airport_seo
  end
end
