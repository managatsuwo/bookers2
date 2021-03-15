Rails.application.routes.draw do
 root 'books#index'
  devise_for :users
  resources :post_images, only: [:new, :create, :index, :show, :destroy]
end
