Rails.application.routes.draw do
    get 'home/about' => 'homes#about'
    devise_for :users
    root :to =>'homes#top'
    resources :users do
     resource :relationships, only: [:create, :destroy]
    end
    resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
    end

  end

