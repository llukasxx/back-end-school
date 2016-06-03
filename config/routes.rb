Rails.application.routes.draw do
  root 'home#index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      devise_scope :user do
        match '/sessions' => 'sessions#create', via: :post
        match '/sessions' => 'sessions#destroy', via: :delete
      end
      scope '/groups' do
        get '/teacher_groups', to: 'groups#teacher_groups'
        get '/teacher_group', to: 'groups#teacher_group'
      end
      scope '/students' do
        resources :grades, only: [:show, :create, :update]
      end
      scope '/conversations' do
        get '/get_conversations', to: 'conversations#get_conversations'
        post '/reply/:id', to: 'conversations#reply_to_conversation'
        post '/reply', to: 'conversations#new_conversation'
      end
    end
  end
end