Rails.application.routes.draw do
  resources :users, only: %i(new create)
  resources :sessions, only: %i(new create destroy)
  root "static_pages#home"

  namespace :app do
    resources :headquarters, only: %i(create show) do
      resources :projects, only: %i(index new create)
      resources :hq_memberships, only: %i(index)
    end

    resources :projects, only: %i(show)
  end
end
