Rails.application.routes.draw do
  resources :users, only: %i(create)
  root "static_pages#home"
end
