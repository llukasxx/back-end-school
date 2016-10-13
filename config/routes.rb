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
      scope '/conversations' do
        get '/get_conversations', to: 'conversations#get_conversations'
        post '/reply/:id', to: 'conversations#reply_to_conversation'
        post '/reply', to: 'conversations#new_conversation'
        post '/new_broadcast_conversation', to: 'conversations#new_broadcast_conversation'
      end
    end
  end
end