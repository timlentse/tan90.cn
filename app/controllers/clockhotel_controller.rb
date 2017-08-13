class ClockhotelController < ApplicationController
  def show
    @hotel = ClockHotel.find_by!(elong_id: params[:id])
    args = {page_type: 'detail', city_cn: @hotel.city_name, city_en: @hotel.city_name_en, hotel_name: @hotel.name, chain_name: @hotel.chain_name}
    set_seo_elements(args)
    @hotel_detail = ClockHotelDetail.parse_each_field(@hotel.id)
  end

  def list
    @hotels = ClockHotel.search(city_name_en: params[:city_name_en], page: params[:page])
    @rooms = ClockHotelDetail.find_rooms(@hotels)
    render 'list.js.erb' and return if request.xhr?
    sample_hotel = @hotels[0]
    set_seo_elements(page_type: 'list', city_cn: sample_hotel.city_name, city_en: sample_hotel.city_name_en)
  end

  private
  def set_seo_elements(args = {})
    @seo = ClockhotelSeo.new(args)
    @tdk = @seo.get_tdk
  end
end
