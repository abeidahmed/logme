class Authentication
  def initialize(params)
    @email    = params[:email].downcase # if user enters uppercase or capitalized email
    @password = params[:password]
  end

  attr_reader :email, :password

  def authenticated?
    !!user
  end

  def user
    find_by_credentials
  end

  private
  def find_by_credentials
    @user ||= User.find_by_email(email)
    return nil unless @user
    @user.authenticate(password) ? @user : nil
  end
end