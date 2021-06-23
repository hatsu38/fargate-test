Rails.application.routes.draw do
  require 'sidekiq/web'
  root "users#index"

  resources :blogs
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    resources :health_check, only: :index
  end
  mount Sidekiq::Web, at: "/sidekiq"
end
