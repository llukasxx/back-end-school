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
    end
  end
end