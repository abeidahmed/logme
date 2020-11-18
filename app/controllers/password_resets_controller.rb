class PasswordResetsController < ApplicationController
  def new
  end

  def create
    user = PasswordReset::Initiator.new(email: params[:email])

    if user.initialized_reset
      logout_user
      redirect_to password_reset_url(user.id)
    else
      render json: { errors: user.errors }, status: :bad_request
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
    redirect_to new_password_reset_url, alert: "Password reset has expired" if @user.password_reset_token_expired?
  end

  def update
    user = PasswordReset::Persistor.new(
      reset_token: params[:id],
      password: params[:password],
      confirm_password: params[:confirm_password]
    )

    if user.reset_password
      logout_user
      redirect_to new_session_url, success: "Now you can login with your new password"
    else
      render json: { errors: user.errors }, status: :bad_request
    end
  end
end
