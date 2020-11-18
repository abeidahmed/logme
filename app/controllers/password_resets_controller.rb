class PasswordResetsController < ApplicationController
  def create
    user = PasswordReset::Initiator.new(email: params[:email])

    if user.initialized_reset
      cookies.delete(:auth_token)
      redirect_to password_reset_url(user.id)
    else
      render json: { errors: user.errors }, status: :bad_request
    end
  end

  def update
  end
end
