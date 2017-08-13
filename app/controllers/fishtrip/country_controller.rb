class Fishtrip::CountryController < ApplicationController
  def index
    @hotels = FishtripHotel.search_hot(params[:country])
    @seo = FishtripSeo.new('country', @hotels)
    @tdk = @seo.tdk
    @comments = FishtripComment.find_hotels_comments(@hotels)
    render 'city.html.erb'
  end

  def city
    @city = FishtripCity.find_by!(name_en: params[:city_en])
    @hotels = @city.hotels.includes(:comments, :rooms).page(params[:page])
    render 'city.js.erb' and return if request.xhr?
    @seo = FishtripSeo.new('city', @hotels)
    @tdk = @seo.tdk
    @comments = FishtripComment.find_hotels_comments(@hotels)
  end
end
