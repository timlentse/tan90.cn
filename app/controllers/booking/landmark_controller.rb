class Booking::LandmarkController < ApplicationController
  def show
    @location = BookingLandmark.find(params[:id])
    hotel_ids = JSON.parse(@location.hotels)
    @hotels = BookingHotel.find_hotels_by_ids(hotel_ids)
    set_seo_elements('landmark')
    @comments = BookingReview.find_comments(@hotels, @language)
    render "show_#{@language}"
  end

  private

  def set_seo_elements(page_type)
    @seo = BookingSeo.new(@location, page_type, @language, @hotels.first)
    @tdk = @seo.get_tdk
  end
end
