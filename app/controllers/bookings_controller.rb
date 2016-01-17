class BookingsController < ApplicationController
  before_filter :set_params
  before_filter :find_city_by_full_name, only:['city_list_by_get','city_list_by_post']
  before_filter :find_landmark_by_id, only: ['landmark'] 

  def country
    @cities = BookingCity.where("country_code=? and city_ranking>0", params[:country])
    @seo = BookingSeo.new(@cities,'country')
    @tdk = @seo.get_tdk
    @breadcrumb = @seo.get_breadcrumb
    @footer_links = []
  end

  def city_list_by_get
    @hotels = BookingHotel.search(@filter_args)
    @seo = BookingSeo.new(@city,'city')
    set_seo_element
    render 'list.html.erb'
  end

  def city_list_by_post
    @hotels = BookingHotel.search(@filter_args)
    @comments = {}
    render 'list.js.erb'
  end

  def landmark
    hotel_ids = JSON.parse(@landmark.hotels)
    @hotels = BookingHotel.find_hotels_by_ids(hotel_ids)
    @seo = BookingSeo.new(@landmark,'landmark')
    set_seo_element
    render 'list.html.erb'
  end

  private
  def set_params
    @filter_args = params.permit(:city_unique, :page)
    @filter_args[:cc1] = params[:country]
  end

  def find_city_by_full_name
    @city = BookingCity.find_by(:full_name=>params[:city_unique])
    render_404 unless @city
  end

  def find_landmark_by_id
    @landmark = BookingLandmark.find(params[:id])
    render_404 unless @landmark and @landmark.country_code=='cn'
  end

  def set_seo_element
    @tdk = @seo.get_tdk
    @breadcrumb = @seo.get_breadcrumb
    @comments = BookingReview.find_comments(@hotels)
    @landmarks = @seo.get_landmarks_with_city
    @location = @city||@landmark
    @footer_links = []
  end

end
