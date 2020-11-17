class App::ApplicationController < ApplicationController
  layout "app"

  before_action :authenticate_user
  after_action :verify_authorized, except: %i(index)
  after_action :verify_policy_scoped, only: %i(index)

  private
  def authenticate_user
    redirect_to new_session_url, alert: "Please signup or login to continue" unless user_signed_in?
  end
end