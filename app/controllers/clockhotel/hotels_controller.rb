class Clockhotel::HotelsController < ApplicationController

  def show
    @hotel = ClockHotel.find_by(:elong_id=>params[:id])
    render_404 unless @hotel
    @page_type = 'detail'
    @city = {:en=>@hotel.city_name_en,:cn=>@hotel.city_name}
    @hotel_detail = ClockHotelDetail.parse_each_field(@hotel.id)
    @tdk = get_tdk
    @breadcrumb = get_breadcrumb
  end

  def list
    @hotels = ClockHotel.search(:city_name_en=>params[:city_name_en])
    render_404 if @hotels.empty?
    @city = {:en=>@hotels[0].city_name_en,:cn=>@hotels[0].city_name}
    @page_type = 'list'
    @tdk = get_tdk
    @breadcrumb = get_breadcrumb
    @rooms = ClockHotelDetail.find_rooms(@hotels)
  end

  private

  def get_tdk
    case @page_type
    when 'detail'
      {
        :title=>"#{@hotel.name}钟点房_钟点房",
        :keywords=>"钟点房,钟点房预订,#{@city[:cn]}钟点房,#{@hotel.chain_name}钟点房",
        :description=>'',
        :h1=>"#{@hotel.name}"
      }
    when 'list'
      {
        :title=>"#{@city[:cn]}钟点房_钟点房",
        :keywords=>"#{@city[:cn]}钟点房,#{@city[:cn]}钟点房预订",
        :description=>'',
        :h1=>"#{@city[:cn]}钟点房"
      }
    end
  end

  def get_breadcrumb
    case @page_type
    when 'detail'
      [{:text=>'首页',:url=>"/"},{:text=>"#{@city[:cn]}钟点房",:url=>"/clockhotel/#{@city[:en]}/"},{:text=>"#{@hotel.name}钟点房"}]
    when 'list'
      [{:text=>'首页',:url=>"/"},{:text=>"#{@city[:cn]}钟点房"}]
    end
  end

end
