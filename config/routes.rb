Rails.application.routes.draw do
  devise_for :owners
  root 'home#index'
  resources :buffets, only: [:show, :new, :create, :edit, :update]
end
