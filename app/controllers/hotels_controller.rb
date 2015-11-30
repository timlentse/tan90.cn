require 'seo'
require 'city'

class HotelsController < ApplicationController
  before_filter :set_params

  def index
    Seo.init_var(@params, 'index', [])
    @seo = {
      :title=>'台湾，日本，泰国，韩国民宿，客栈预订',
      :keywords=>'民宿,客栈',
      :description=>'为你推荐台湾，日本，泰国，韩国民宿客栈'
    }
    @footer_links = Seo.get_footer_links
  end

  def country
    if @params[:page]
      redirect_to URI(request.original_url).path, status: 301
    else
      @hotels = Hotel.search_hot(@params[:country])
      if @hotels.empty?
        render_404
      else
        Seo.init_var(@params, 'country', @hotels)
        @seo = Seo.tdk
        @breadcrumb = Seo.get_breadcrumb
        @footer_links = Seo.get_footer_links
        render 'list.html.erb'
      end
    end
  end

  def get_city
    if @params[:page]
      redirect_to URI(request.original_url).path, status: 301
    else
      render_page('city')
    end
  end

  def post_city
    @hotels = Hotel.search(@params)
    render 'list.js.erb'
  end

  def sitemap
    @seo={:title=>'酒店名录', :keywords=>'酒店,名录', :description=>'酒店大全汇总', :h1=>'酒店名录'}
    @links = Seo.get_sitemap_links
  end

  private

  def set_params
    @params = params.permit(:country, :page, :city_en)
  end

  def find_city_id(city_en)
  end

  def render_page(page_type)
    @hotels = Hotel.search(@params)
    if @hotels.empty?
      render_404
    else
      Seo.init_var(@params, page_type, @hotels)
      @seo = Seo.tdk
      @breadcrumb = Seo.get_breadcrumb
      @footer_links = Seo.get_footer_links
      render 'list.html.erb'
    end
  end

end
