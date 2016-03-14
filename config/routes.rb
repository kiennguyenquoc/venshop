Rails.application.routes.draw do
  devise_for :admins
  devise_for :users

  get 'carts/index'
  get 'search' => 'search#search'

  root to: "static_pages#home"

  get 'help' => 'static_pages#help'
  get 'about' => 'static_pages#about'
  get 'error' => 'static_pages#error'

  resources :categories, only: [:index, :show]
  resources :products
  resources :carts
  resources :cart_products, only: [:create, :destroy, :update]
  resources :shopping_history, only: [:index]

  namespace :admin do
    resources :products, :carts,  :users
  end

end
