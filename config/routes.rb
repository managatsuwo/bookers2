Rails.application.routes.draw do
    get 'home/about' => 'homes#about'
    devise_for :users
    root :to =>'homes#top'
    resources :users
    resources :books do
    resources :favorites, only: [:create, :destroy]
    end

  end

