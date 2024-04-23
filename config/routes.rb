Rails.application.routes.draw do
  devise_for :owners
  root 'home#index'
  resources :buffets, only: [:show, :new, :create, :edit, :update] do
    resources :event_types, only: [:index, :new, :create]
  end

  resources :event_types, only: [:edit, :update]
end
