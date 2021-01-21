Rails.application.routes.draw do
  devise_for :users
  root'home#index'
  
  resources :promotions do
    post 'generate_coupons', on: :member
  end

  resources :product_categories


  resources :coupons, only: [] do
    post 'inactivate', on: :member
    post 'active', on: :member
    get 'search', on: :collection
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

