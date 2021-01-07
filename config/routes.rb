Rails.application.routes.draw do
  root'home#index'
  resources :promotions, only: %i[index show new create update edit]
  resources :product_categories, only: %i[index]
end
