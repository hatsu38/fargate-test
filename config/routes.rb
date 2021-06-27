Rails.application.routes.draw do
  devise_for :employee_authenticates
  require 'sidekiq/web'
  root "blogs#index"

  resources :blogs
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :employee_profiles do
    scope module: :employee_profiles do
      resource :leave, only: %i[show destroy]
    end
  end

  namespace :api do
    resources :health_check, only: :index
  end
  mount Sidekiq::Web, at: "/sidekiq"
  mount Flipper::UI.app(Flipper) => '/flipper'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
