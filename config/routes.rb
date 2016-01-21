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
  get '/booking/:country/:city_unique/'=>'bookings#city_list_by_get', country: /[a-z]{2}/, city_unique: /[a-z\-\d]+/
  post '/booking/:country/:city_unique/'=>'bookings#city_list_by_post', country: /[a-z]{2}/, city_unique: /[a-z\-\d]+/
  get '/booking/landmark/:id/'=>'bookings#landmark', id: /\d+/
  get '/booking/airport/:iata/'=>'bookings#airport', iata: /[a-z]{3}/
end
