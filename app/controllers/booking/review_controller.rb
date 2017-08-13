class Booking::ReviewController < ApplicationController
  def show
    @location = BookingCity.includes(:airports).find_by!(country_code: params[:country], full_name: params[:city_unique])
    @hotels = @location.hotels.page(params[:page])
    set_seo_elements('review')
    @reviews = BookingReview.find_6_reviews(@hotels, @language)
    render "show_#{@language}"
  end

  private

  def set_seo_elements(page_type)
    @seo = BookingSeo.new(@location, page_type, @language)
    @tdk = @seo.get_tdk
  end
end
