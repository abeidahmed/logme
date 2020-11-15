Rails.application.routes.draw do
  resources :users, only: %i(new create)
  root "static_pages#home"
end
