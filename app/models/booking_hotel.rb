class BookingHotel < ActiveRecord::Base
  def self.search(params)
    BookingHotel.where(:cc1=>params[:country], :city_unique=>params[:city_en]).limit(21)
  end
end
