Rails.application.routes.draw do

  root 'hotels#index'
  get '/sitemap.html/'=>'hotels#sitemap'
  get '/:country/'=>'hotels#country'
  get '/:country/:city_en/'=>'hotels#get_city'
  post '/:country/:city_en/'=>'hotels#post_city'
end
