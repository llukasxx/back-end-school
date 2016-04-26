Rails.application.routes.draw do
  root 'home#index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :lessons
  resources :groups
  devise_for :users
  namespace :api,defaults: {format: :json} do
    namespace :v1 do
      devise_scope :user do
        match '/sessions' => 'sessions#create', via: :post
        match '/sessions' => 'sessions#destroy', via: :delete
      end
    end
  end
end