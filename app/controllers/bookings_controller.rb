class BookingsController < ApplicationController
  before_filter :set_params
  def country
    @cities = BookingCity.where("country_code=? and city_ranking>0", params[:country])
    @seo = BookingSeo.new(@cities,'country')
    @tdk = @seo.get_tdk
    @breadcrumb = @seo.get_breadcrumb
    @footer_links = []
  end

  def city_list_by_get
    render_404 unless @city
    @hotels = BookingHotel.search(@params)
    @seo = BookingSeo.new(@city,'city',@hotels)
    @tdk = @seo.get_tdk
    @breadcrumb = @seo.get_breadcrumb
    @footer_links = []
    render 'list.html.erb'
  end

  def city_list_by_post
    render_404 unless @city
    @hotels = BookingHotel.search(@params)
    render 'list.js.erb'
  end

  private
  def set_params
    @params = params.permit(:city_unique, :page)
    @params[:cc1] = params[:country]
    @city = BookingCity.find_by(:full_name=>params[:city_unique])
  end
end
