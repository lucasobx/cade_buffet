Rails.application.routes.draw do
  devise_for :clients
  devise_for :owners
  root 'home#index'
  resources :buffets, only: [:show, :new, :create, :edit, :update] do
    get 'search', on: :collection
    resources :event_types, only: [:new, :create]
  end
  resources :event_types, only: [:show, :edit, :update]
  resources :orders, only: [:show, :new, :create, :edit, :update] do
    post 'confirmed', on: :member
    post 'canceled', on: :member
    patch 'approved', on: :member
  end

  scope :client do
    get :my_orders, to: 'orders#index', as: 'client_orders'
  end

  scope :owner do
    get :my_buffet_orders, to: 'orders#my_buffet_orders', as: 'buffet_orders'
  end

  namespace :api do
    namespace :v1 do
      resources :buffets, only: [:index, :show] do
        resources :event_types, only: [:index]
      end
    end
  end

  namespace :api do
    namespace :v1 do
      resources :event_types, only: [:show]
    end
  end
end
