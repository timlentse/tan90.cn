class FishtripsController < ApplicationController
  before_filter :set_params, :set_spider_track

  def index
    @page_type = 'index'
    @seo = FishtripSeo.new(@page_type, [])
    @tdk = @seo.tdk
    @footer_links = @seo.get_footer_links
  end

  def country
    @page_type = 'country'
    @hotels = FishtripHotel.search_hot(@params[:country])
    if @hotels.empty?
      render_404
    else
      @seo = FishtripSeo.new(@page_type, @hotels)
      @tdk = @seo.tdk
      @breadcrumb = @seo.get_breadcrumb
      @footer_links = @seo.get_footer_links
      render 'list.html.erb'
    end
  end

  def city_for_get
    @page_type = 'city'
    @params[:city_id] = find_city_id(params[:city_en])
    render_list_page
  end

  def city_for_post
    @params[:city_id] = find_city_id(params[:city_en])
    @hotels = FishtripHotel.search(@params)
    render 'list.js.erb'
  end

  def detail
    @hotel = FishtripHotel.find_by(:fishtrip_hotel_id=>params[:id])
    render_404 unless @hotel
    if @spider_track
      render_detail_page
    else
      redirect_to @hotel.shared_uri, :status=>301
    end
  end

  def query_for_get
    @page_type = 'query'
    @params[:city_id] = search_city_by_keyword
    render_list_page
  end

  def query_for_post
    @params[:city_id] = search_city_by_keyword
    @hotels = FishtripHotel.search(@params)
    render 'list.js.erb'
  end

  private

  def set_params
    @params = params.permit(:country, :page)
  end

  def set_spider_track
    @spider_track = request.bot?
  end

  def find_city_id(city_en)
    @city = FishtripCity.find_by(:name_en=>city_en)
    @city.nil? ? 0 : @city.id
  end

  def render_list_page
    @hotels = FishtripHotel.search(@params)
    if @hotels.empty?
      render_404
    else
      @seo = FishtripSeo.new(@page_type, @hotels)
      @tdk = @seo.tdk
      @breadcrumb = @seo.get_breadcrumb
      @comments = FishtripComment.find_hotels_comments(@hotels)
      @footer_links = @seo.get_footer_links
      render 'list.html.erb'
    end
  end

  def search_city_by_keyword
    @city = FishtripCity.find_by(:name=>params[:q])
    @city.nil? ? 0 : @city.id
  end

  def render_detail_page
    @page_type = 'detail'
    @tuijian = @hotel.tuijian.nil? ? [] : JSON.parse(@hotel.tuijian)
    @detail_comments = @hotel.fishtrip_comments
    @seo = FishtripSeo.new(@page_type, @hotel)
    @footer_links = @seo.get_footer_links
    @tdk = @seo.tdk
    @breadcrumb = @seo.get_breadcrumb
    @recommend_hotels = FishtripHotel.select_recommend_hotels(@hotel.city_id, @hotel.id)
  end

end
