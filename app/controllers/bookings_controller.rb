class BookingsController < ApplicationController
  before_filter :set_params
  before_filter :find_city_by_full_name, only:['city_list_by_get','city_list_by_post', 'city_review']
  before_filter :find_landmark_by_id, only: ['landmark'] 

  def country
    @cities = BookingCity.where("country_code=? and city_ranking>0", params[:country])
    render_404 if @cities.empty?
    @language = Constant::LANG_CN_CC.include?(params[:country]) ? "cn" : "en"
    @seo = BookingSeo.new(@cities,'country', @language)
    @tdk = @seo.get_tdk
    @breadcrumb = @seo.get_breadcrumb
    render "country_#{@language}"
  end

  def city_list_by_get
    @hotels = BookingHotel.search(@filter_args)
    set_seo_elements('city')
    @comments = BookingReview.find_comments(@hotels,@language)
    @landmarks = @seo.get_landmarks_with_city
    @airports = find_airports_in_city
    render "list_#{@language}"
  end

  def city_list_by_post
    @hotels = BookingHotel.search(@filter_args)
    @comments = {}
    @location = @city||@landmark||@airport
    @language = get_language
    render "list_#{@language}.js.erb"
  end

  def landmark
    hotel_ids = JSON.parse(@landmark.hotels)
    @hotels = BookingHotel.find_hotels_by_ids(hotel_ids)
    set_seo_elements('landmark')
    @comments = BookingReview.find_comments(@hotels, @language)
    render "list_#{@language}"
  end

  def airport
    @airport = BookingAirport.find_by(:iata=>params[:iata].upcase)
    render_404 unless @airport
    @hotels = JSON.parse(@airport.hotels)
    set_seo_elements('airport')
    render "airport_#{@language}"
  end

  def city_review
    @hotels = BookingHotel.search(@filter_args)
    set_seo_elements('review')
    @reviews = BookingReview.find_6_reviews(@hotels, @language)
    render "review_#{@language}"
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

  def find_airports_in_city
    BookingAirport.airports(@city.full_name,@language)
  end

  def set_seo_elements(page_type)
    @page_type = page_type
    @location = @city||@landmark||@airport
    @language = get_language
    @seo = BookingSeo.new(@location, @page_type, @language)
    @tdk = @seo.get_tdk
    @breadcrumb = @seo.get_breadcrumb
  end

  def get_language
    if params[:country]
      Constant::LANG_CN_CC.include?(params[:country]) ? "cn" : "en"
    else
      Constant::LANG_CN_CC.include?(@location.country_code) ? "cn" : "en"
    end
  end
end
