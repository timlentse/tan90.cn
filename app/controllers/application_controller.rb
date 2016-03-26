class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :is_device_mobile?, :set_spider_track

  private

  def render_404
    raise ActionController::RoutingError.new('Not Found')
  end

  def is_device_mobile?
    user_agent = request.headers["HTTP_USER_AGENT"]
    @is_mobile =  user_agent.present? && user_agent =~ /\b(Android|iPhone|iPad|Windows Phone|Opera Mobi|Kindle|BackBerry|PlayBook|UCWEB|Mobile)\b/i
  end

  def set_spider_track
    @spider_tracked = request.bot?
  end

end
