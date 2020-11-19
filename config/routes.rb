Rails.application.routes.draw do
  resources :users, only: %i(new create)
  resources :sessions, only: %i(new create destroy)
  resources :password_resets, only: %i(new create show edit update)
  root "static_pages#home"

  namespace :app do
    resources :headquarters, only: %i(index create show update) do
      resources :projects, only: %i(new create)
      resources :hq_memberships, only: %i(index create)
    end

    resources :projects, only: %i(show) do
      resources :project_memberships, only: %i(index)
    end

    resources :hq_invitations, only: %i(show update destroy)
  end
end
