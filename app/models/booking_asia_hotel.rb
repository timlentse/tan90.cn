class BookingAsiaHotel < ActiveRecord::Base
  def self.search(params)
    BookingAsiaHotel.where(:cc1=>params[:country], :city_unique=>params[:city_en]).limit(21)
  end
end
