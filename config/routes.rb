Rails.application.routes.draw do
  devise_for :clients
  devise_for :owners
  root 'home#index'
  resources :buffets, only: [:show, :new, :create, :edit, :update] do
    get 'search', on: :collection
    resources :event_types, only: [:new, :create]
  end
  resources :event_types, only: [:show, :edit, :update]
  resources :orders, only: [:show, :new, :create] do
    get 'approve', on: :member
    post 'confirmed', on: :member
    post 'canceled', on: :member
  end

  scope :client do
    get :my_orders, to: 'orders#index', as: 'client_orders'
  end

  scope :owner do
    get :my_buffet_orders, to: 'orders#my_buffet_orders', as: 'buffet_orders'
  end
end
