require 'seo'
require 'city'
require 'comment'

class HotelsController < ApplicationController
  before_filter :set_params

  def index
    @page_type = 'index'
    @seo = Seo.new(@page_type, [])
    @tdk = @seo.tdk
    @footer_links = @seo.get_footer_links
  end

  def country
    @page_type = 'country'
    if @params[:page]
      redirect_to URI(request.original_url).path, status: 301
    else
      @hotels = Hotel.search_hot(@params[:country])
      if @hotels.empty?
        render_404
      else
        @seo = Seo.new(@page_type, @hotels)
        @tdk = @seo.tdk
        @breadcrumb = @seo.get_breadcrumb
        @footer_links = @seo.get_footer_links
        render 'list.html.erb'
      end
    end
  end

  def city_for_get
    @page_type = 'city'
    if @params[:page]
      redirect_to URI(request.original_url).path, status: 301
    else
      @params[:city_id] = find_city_id(params[:city_en])
      render_page
    end
  end

  def city_for_post
    @params[:city_id] = find_city_id(params[:city_en])
    @hotels = Hotel.search(@params)
    render 'list.js.erb'
  end

  def detail
    @page_type = 'detail'
    @hotel = Hotel.find_by(:fishtrip_hotel_id=>params[:id])
    @tuijian = @hotel.tuijian.nil? ? [] : JSON.parse(@hotel.tuijian)
    @comments = @hotel.comments
    @seo = Seo.new(@page_type, @hotel)
    @footer_links = @seo.get_footer_links
    @tdk = @seo.tdk
    @breadcrumb = @seo.get_breadcrumb
  end

  def query_for_get
    @page_type = 'query'
    @params[:city_id] = search_city_by_keyword
    render_page
  end

  def query_for_post
    @params[:city_id] = search_city_by_keyword
    @hotels = Hotel.search(@params)
    render 'list.js.erb'
  end

  private

  def set_params
    @params = params.permit(:country, :page)
  end

  def find_city_id(city_en)
    city = City.find_by(:name_en=>city_en)
    city.nil? ? 0 : city.id
  end

  def render_page
    @hotels = Hotel.search(@params)
    if @hotels.empty?
      render_404
    else
      @seo = Seo.new(@page_type, @hotels)
      @tdk = @seo.tdk
      @breadcrumb = @seo.get_breadcrumb
      @footer_links = @seo.get_footer_links
      render 'list.html.erb'
    end
  end

  def search_city_by_keyword
    city = City.find_by(:name=>params[:q])
    city.nil? ? 0 : city.id
  end

end
