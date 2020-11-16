Rails.application.routes.draw do
  resources :users, only: %i(new create)
  resources :sessions, only: %i(new create)
  root "static_pages#home"

  namespace :app do
    resources :headquarters, only: %i(index create) do
      resources :projects, only: %i(index create)
    end
  end
end
