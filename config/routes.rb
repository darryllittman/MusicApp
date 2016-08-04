Rails.application.routes.draw do
  resources :users, only: [:create, :new, :show]
  resource :session, only: [:new, :create, :destroy]

  resources :bands

  resources :albums, only: [:create, :new, :show, :destroy, :edit]
end
