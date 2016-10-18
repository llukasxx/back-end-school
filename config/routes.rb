Rails.application.routes.draw do
  get 'events/index'

  root 'home#index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      devise_scope :user do
        match '/sessions' => 'sessions#create', via: :post
        match '/sessions' => 'sessions#destroy', via: :delete
      end
      resources :groups, only: [:index]
      resources :teachers, only: [:index] do
        resources :grades, except: [:destroy]
        resources :groups, only: [:index]
      end
      resources :students, only: [:index] do
        resources :grades, only: [:index]
        resources :lessons, only: [:index]
      end
      resources :grades, only: [:show, :create, :update]
      resources :lessons, only: [:index]
      resources :events, only: [:index, :create]
      resources :conversations, only: [:index, :create, :update]
      scope module: 'receivers' do
        resources :receivers_teachers, :receivers_students, :receivers_groups, :receivers_lessons, only: [:index]
      end
    end
  end
end