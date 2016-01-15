Rails.application.routes.draw do
  root 'fishtrips#index'
  get '/search/'=>'fishtrips#query_for_get'
  post '/search/'=>'fishtrips#query_for_post'
  get '/:id/'=>'fishtrips#detail', id: /\d+/
  get '/:country/'=>'fishtrips#country', country: /[a-zA-Z_]+/
  get '/:country/:city_en/'=>'fishtrips#city_for_get'
  post '/:country/:city_en/'=>'fishtrips#city_for_post'
end
