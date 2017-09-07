class BookingController < ApplicationController
  def show
    @hotel = BookingHotel.includes(:city).find(params[:id])
    redirect_to @hotel.shared_uri, status: 302 and return unless request.bot?
    @location = @hotel.city
    set_seo_elements('detail')
    @comments = BookingReview.find_comments_with_hotel(@hotel, @language)
    render "show_#{@language}"
  end

  private

  def set_seo_elements(page_type)
    @seo = BookingSeo.new(@location, page_type, @language, @hotel)
    @tdk = @seo.get_tdk
  end
end
