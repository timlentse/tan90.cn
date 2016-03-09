class CommonsController < ApplicationController

  def index
    @tdk = Common.tdk
    @booking_hot_destinations = Common.get_hot_destinations
    @fishtrip_links = Common.get_fishtrip_links
    @cities = {}
    ['taiwan','japan','thailand','korea'].each do |country|
      @cities[country]=FishtripCity.where(country:country).take(3)
    end
  end

end
