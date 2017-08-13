class Booking::CountryController < ApplicationController
  def index
    @cities = BookingCity.where("country_code=? and city_ranking>0", params[:country])
    @seo = BookingSeo.new(@cities, 'country', @language)
    @tdk = @seo.get_tdk
    render "index_#{@language}"
  end

  def city
    @location = BookingCity.includes(:airports).find_by!(country_code: params[:country], full_name: params[:city_unique])
    @hotels = @location.hotels.includes(:reviews).page(params[:page])
    @comments = BookingReview.find_comments(@hotels, @language)
    render "city_#{@language}.js.erb" and return if request.xhr?
    set_seo_elements('city')
    @landmarks = @seo.get_landmarks_with_city
    render "city_#{@language}"
  end

  private

  def set_seo_elements(page_type)
    @seo = BookingSeo.new(@location, page_type, @language)
    @tdk = @seo.get_tdk
  end
end
