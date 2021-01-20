Rails.application.routes.draw do
  devise_for :users
  root'home#index'
  
  resources :promotions, only: %i[index show new create update edit destroy] do
    post 'generate_coupons', on: :member
  end

  #resources :coupons %i[show] do
   # get 'search', 
  #end

  resources :product_categories, only: %i[index show new create destroy edit update]

  resources :coupons, only: [] do
    post 'inactivate', on: :member
  end

  resources :coupons, only: [] do
    post 'active', on: :member
  end

  namespace 'api' do
    namespace 'v1' do
      resources :coupons, param: :code, only: %i[show] do
        post 'burn', on: :member
      end
      #get 'coupons/:code', to: 'coupons#show'
      #post 'coupons/:code/burn', to: 'coupons#burn'
      end 
  end

end

