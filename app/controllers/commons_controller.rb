class CommonsController < ApplicationController

  def index
    @tdk = Common.tdk
    @footer_links = []
  end

end
