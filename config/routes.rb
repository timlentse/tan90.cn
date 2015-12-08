Rails.application.routes.draw do
  root 'hotels#index'
  get '/search/'=>'hotels#query_for_get'
  post '/search/'=>'hotels#query_for_post'
  get '/:id/'=>'hotels#detail', id: /\d+/
  get '/:country/'=>'hotels#country', country: /[a-zA-Z_]+/
  get '/:country/:city_en/'=>'hotels#city_for_get'
  post '/:country/:city_en/'=>'hotels#city_for_post'
end
