Rails.application.routes.draw do
  get 'products/index'

  devise_for :users
  namespace :api,defaults: {format: :json} do
    namespace :v1 do
      resources :users
      match '/product' => 'products#index', via: :get
      devise_scope :user do
        match '/sessions' => 'sessions#create', via: :post
        match '/sessions' => 'sessions#destroy', via: :delete
      end
    end
  end
end