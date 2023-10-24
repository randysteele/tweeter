require 'sidekiq/web'

Rails.application.routes.draw do
    authenticate :user, lambda { |u| u.admin? } do
      mount Sidekiq::Web => '/sidekiq'
    end
  

  devise_for :users
  resources :tweets, except: [:edit, :update]
  root to: 'tweets#index'
  resources :profiles


  resources :tweets, except: [:edit, :update] do
    resources :comments, only: [:create, :destroy]
    member do
      post :retweet
    end
  end
 end

