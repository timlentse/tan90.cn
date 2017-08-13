class Booking::AirportController < ApplicationController
  def show
    @location = BookingAirport.find_by!(iata: params[:id].upcase)
    set_seo_elements('airport')
    render "show_#{@language}"
  end

  private

  def set_seo_elements(page_type)
    @seo = BookingSeo.new(@location, page_type, @language)
    @tdk = @seo.get_tdk
  end
end
