Rails.application.routes.draw do
  root 'commons#index'

  # Router for fishtrip
  get '/fishtrip//search/'=>'fishtrips#query_by_get'
  post '/fishtrip/search/'=>'fishtrips#query_by_post'
  get '/fishtrip/:id/'=>'fishtrips#detail', id: /\d+/
  get '/fishtrip/:country/'=>'fishtrips#country', country: /[a-zA-Z_]+/
  get '/fishtrip/:country/:city_en/'=>'fishtrips#city_list_by_get'
  post '/fishtrip/:country/:city_en/'=>'fishtrips#city_list_by_post'

  # Router for booking
  get '/booking/:country/'=>'bookings#country', country: /[a-z]{2}/
  get '/booking/:country/:city_en/'=>'bookings#city_list_by_get', country: /[a-z]{2}/, city_en: /[a-z\-\d]+/
end
