class SessionsController < ApplicationController
  def new
    redirect_to root_url if user_signed_in?
  end

  def create
    auth = Authentication.new(params)

    if auth.authenticated?
      login(auth.user)
      redirect_to root_url, success: "Successfully signed in"
    else
      render json: { errors: { invalid: ["credentials"] } }, status: :bad_request
    end
  end

  def destroy
    logout_user
    @current_user = nil
    redirect_to new_session_url, success: "Successfully logged out"
  end
end
