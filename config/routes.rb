Rails.application.routes.draw do
  root 'commons#index'

  # Router for fishtrip
  namespace :fishtrip do
    get "/:id", to: "hotels#show", id: /\d+/
    get '/search', to: 'hotels#query_by_get'
    post '/search', to: 'hotels#query_by_post'
    get '/articles/:article_id', to: 'hotels#articles', article_id: /\d{4}/
    get '/:country', to: 'hotels#country', country: /[a-zA-Z_]+/
    get '/:country/:city_en', to: 'hotels#city_list_by_get'
    post '/:country/:city_en', to: 'hotels#city_list_by_post'
  end

  # Router for booking
  namespace :booking do
    get '/:country'=>'hotels#country', country: /[a-z]{2}/
    get '/:country/:city_unique'=>'hotels#city_list_by_get', country: /[a-z]{2}/, city_unique: /[a-z\-\d]+/
    post '/:country/:city_unique'=>'hotels#city_list_by_post', country: /[a-z]{2}/, city_unique: /[a-z\-\d]+/
    get '/landmark/:id'=>'hotels#landmark', id: /\d+/
    get '/airport/:iata'=>'hotels#airport', iata: /[a-z]{3}/
    get '/:id'=>'hotels#show',id:/\d+/
    get '/:country/:city_unique/review.html'=>'hotels#city_review', country: /[a-z]{2}/, city_unique: /[a-z\-\d]+/
  end


  # Router for clock hotels
  namespace :clockhotel do
    get '/:id'=>'hotels#show',:id=>/\d+/
    get '/:city_name_en'=>'hotels#list', city_name_en: /[A-Za-z_]+/
  end
end
