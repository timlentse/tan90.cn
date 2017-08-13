Rails.application.routes.draw do
  root 'home#index'

  # Router for fishtrip
  resources :fishtrip, only: [:show] do
    collection do
      resources :articles, controller: 'fishtrip/articles', only: [:show]
      get '/:country', to: 'fishtrip/country#index', country: /[a-zA-Z_]+/
      get '/:country/:city_en', to: 'fishtrip/country#city'
    end
  end

  # Router for booking
  resources :booking, only: [:show] do
    collection do
      resources :landmark, controller: 'booking/landmark', only: [:show]
      resources :airport, controller: 'booking/airport', only: [:show]
      get '/:country', to: 'booking/country#index', country: /[a-z]{2}/
      get '/:country/:city_unique', to: 'booking/country#city'
      get '/:country/:city_unique/review.html', to: 'booking/review#show'
    end
  end

  # Router for clock hotels
  resources :clockhotel, only: [:show] do
    collection do
      get '/:city_name_en', to: 'clockhotel#list', city_name_en: /[A-Za-z_]+/
    end
  end
end
