class Fishtrip::ArticlesController < ApplicationController
  def show
    @article = FishtripArticle.find_by!(article_id: params[:id])
    @seo = FishtripSeo.new('article', @article)
    @tdk = @seo.tdk
  end
end
