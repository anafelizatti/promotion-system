Rails.application.routes.draw do
  root'home#index'
  resources :promotions, only: %i[index show new create update edit]
end
