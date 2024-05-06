Rails.application.routes.draw do
  devise_for :clients
  devise_for :owners
  root 'home#index'
  resources :buffets, only: [:show, :new, :create, :edit, :update] do
    get 'search', on: :collection
    resources :event_types, only: [:new, :create]
  end
  resources :event_types, only: [:show, :edit, :update]
  resources :orders, only: [:show, :new, :create]

  scope :client do
    get :my_orders, to: 'orders#index', as: 'client_orders'
  end
end
