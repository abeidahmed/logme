module SessionsHelper
  def login(user)
    cookies.permanent[:auth_token] = user.auth_token
  end

  def current_user
    @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
  end

  def user_signed_in?
    !!current_user
  end

  def logout_user
    cookies.delete(:auth_token) if user_signed_in?
  end
end