Rails.application.routes.draw do
  resources :users, only: %i(new create)
  resources :sessions, only: %i(create)
  root "static_pages#home"
end
