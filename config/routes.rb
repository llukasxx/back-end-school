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
      scope '/groups' do
        get '/teacher_groups', to: 'groups#teacher_groups'
        get '/teacher_group', to: 'groups#teacher_group'
        get '/get_groups', to: 'groups#get_groups'
      end
      scope '/students' do
        resources :grades, only: [:show, :create, :update]
        get '/get_students', to: 'students#get_students'
      end
      scope '/teachers' do
        get '/get_teachers', to: 'teachers#get_teachers'
      end
      scope '/conversations' do
        get '/get_conversations', to: 'conversations#get_conversations'
        post '/reply/:id', to: 'conversations#reply_to_conversation'
        post '/reply', to: 'conversations#new_conversation'
        post '/new_broadcast_conversation', to: 'conversations#new_broadcast_conversation'
      end
      scope '/lessons' do
        get '/get_lessons', to: 'lessons#get_lessons'
      end
      scope '/events' do
        get '/get_events', to: 'events#get_upcoming_events'
        get '/get_connected_events', to: 'events#get_upcoming_connected_events'
        get '/get_created_events', to: 'events#get_upcoming_created_events'
        get '/get_past_events', to: 'events#get_past_events'
      end
    end
  end
end