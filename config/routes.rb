Rails.application.routes.draw do

  root 'hotels#index'
  get '/sitemap.html/'=>'hotels#sitemap'
  get '/:id/'=>'hotels#detail', id: /\d+/
  get '/:country/'=>'hotels#country', country: /[a-zA-Z_]+/
  get '/:country/:city_en/'=>'hotels#get_city'
  post '/:country/:city_en/'=>'hotels#post_city'
end
