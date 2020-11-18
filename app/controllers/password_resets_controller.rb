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
    user = PasswordReset::Persistor.new(
      reset_token: params[:id],
      password: params[:password],
      confirm_password: params[:confirm_password]
    )

    if user.reset_password
      cookies.delete(:auth_token)
      redirect_to new_session_url, success: "Now you can login with your new password"
    else
      render json: { errors: user.errors }, status: :bad_request
    end
  end
end
