require 'seo'
require 'city'
require 'comment'

class HotelsController < ApplicationController
  before_filter :set_params

  def index
    @seo = Seo.new('index', [])
    @tdk = {
      :title=>'台湾，日本，泰国，韩国民宿，客栈预订',
      :keywords=>'民宿,客栈',
      :description=>'为你推荐台湾，日本，泰国，韩国民宿客栈'
    }
    @footer_links = @seo.get_footer_links
  end

  def country
    if @params[:page]
      redirect_to URI(request.original_url).path, status: 301
    else
      @hotels = Hotel.search_hot(@params[:country])
      if @hotels.empty?
        render_404
      else
        @seo = Seo.new('country', @hotels)
        @tdk = @seo.tdk
        @breadcrumb = @seo.get_breadcrumb
        @footer_links = @seo.get_footer_links
        render 'list.html.erb'
      end
    end
  end

  def get_city
    if @params[:page]
      redirect_to URI(request.original_url).path, status: 301
    else
      @params[:city_id] = find_city_id(params[:city_en])
      render_page('city')
    end
  end

  def post_city
    @hotels = Hotel.search(@params)
    render 'list.js.erb'
  end

  def detail
    @hotels = Hotel.where(:fishtrip_hotel_id=>params[:id])
    @seo = Seo.new('detail', @hotels)
    @hotel = @hotels.take
    @tuijian = @hotel.tuijian.nil? ? [] : JSON.parse(@hotel.tuijian)
    @comments = @hotel.comments
    @footer_links = @seo.get_footer_links
    @tdk = @seo.tdk
    @breadcrumb = @seo.get_breadcrumb
  end

  def sitemap
    @seo={:title=>'酒店名录', :keywords=>'酒店,名录', :description=>'酒店大全汇总', :h1=>'酒店名录'}
    @links = Seo.get_sitemap_links
  end

  private

  def set_params
    @params = params.permit(:country, :page)
  end

  def find_city_id(city_en)
    city = City.find_by(:name_en=>city_en)
    city.nil? ? 0 : city.id
  end

  def render_page(page_type)
    @hotels = Hotel.search(@params)
    if @hotels.empty?
      render_404
    else
      @seo = Seo.new(page_type, @hotels)
      @tdk = @seo.tdk
      @breadcrumb = @seo.get_breadcrumb
      @footer_links = @seo.get_footer_links
      render 'list.html.erb'
    end
  end

end
