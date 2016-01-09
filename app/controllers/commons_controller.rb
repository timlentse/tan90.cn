class CommonsController < ApplicationController

  def index
    @tdk = Common.tdk
    @hot_destination = Common.get_hot_destination
    @footer_links = []
  end

end
