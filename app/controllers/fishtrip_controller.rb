class FishtripController < ApplicationController
  def show
    @hotel = FishtripHotel.includes(:comments, :rooms).find_by!(fishtrip_hotel_id: params[:id])
    # redirect_to @hotel.shared_uri, status: 302 and return unless request.bot?
    @tuijian = @hotel.tuijian.empty? ? [] : JSON.parse(@hotel.tuijian)
    @seo = FishtripSeo.new('detail', @hotel)
    @tdk = @seo.tdk
    @recommend_hotels = FishtripHotel.select_recommend_hotels(@hotel.city_id, @hotel.id)
    @seo_articles = FishtripArticle.find_seo_article({ city_en: @hotel.city_en, country: @hotel.country })
  end
end
