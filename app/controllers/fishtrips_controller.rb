class FishtripsController < ApplicationController
  before_filter :set_params

  def country
    @page_type = 'country'
    @hotels = FishtripHotel.search_hot(@target_args[:country])
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

  def city_list_by_get
    @page_type = 'city'
    @target_args[:city_id] = find_city_id(params[:city_en])
    render_list_page
  end

  def city_list_by_post
    @target_args[:city_id] = find_city_id(params[:city_en])
    @hotels = FishtripHotel.search(@target_args)
    render 'list.js.erb'
  end

  def detail
    @page_type = 'detail'
    @hotel = FishtripHotel.find_by(:fishtrip_hotel_id=>params[:id])
    @tuijian = @hotel.tuijian.nil? ? [] : JSON.parse(@hotel.tuijian)
    @comments = @hotel.fishtrip_comments
    @seo = FishtripSeo.new(@page_type, @hotel)
    @footer_links = @seo.get_footer_links
    @tdk = @seo.tdk
    @breadcrumb = @seo.get_breadcrumb
    @recommend_hotels = FishtripHotel.select_recommend_hotels(@hotel.city_id, @hotel.id)
    @seo_articles = FishtripArticle.find_seo_article({:city_en=>@hotel.city_en,:country=>@hotel.country})
  end

  def articles
    @page_type = 'article'
    @article = FishtripArticle.find_by(:article_id=>params[:article_id])
    render_404 unless @article
    @seo = FishtripSeo.new(@page_type, @article)
    @tdk = @seo.tdk
    @breadcrumb = @seo.get_breadcrumb
    @footer_links = @seo.get_footer_links
  end

  def query_by_get
    @page_type = 'query'
    @target_args[:city_id] = search_city_by_keyword
    render_page
  end

  def query_by_post
    @target_args[:city_id] = search_city_by_keyword
    @hotels = FishtripHotel.search(@target_args)
    render 'list.js.erb'
  end

  private

  def set_params
    @target_args = params.permit(:country, :page)
  end

  def find_city_id(city_en)
    @city = FishtripCity.find_by(:name_en=>city_en)
    @city.nil? ? 0 : @city.id
  end

  def render_list_page
    @hotels = FishtripHotel.search(@target_args)
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

  def search_city_by_keyword
    @city = FishtripCity.find_by(:name=>params[:q])
    @city.nil? ? 0 : @city.id
  end

end
