# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'
  post '/users/follow', to: 'followers#follow', as: :create_follower
  get '/users/requests', to: 'users#requests', as: :accept_follower_request

  devise_for :users

  resources :users, only: %i[index show edit update] do
    resources :followers, only: %i[new create destroy]
    resources :stories, except: :show

    member do
      post 'search'
    end
    resources :posts, except: :index do
      resources :comments, except: %i[index show]
    end
  end

  resources :likes, only: %i[create destroy]
end
