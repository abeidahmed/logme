class PasswordReset::Persistor
  include ActiveModel::Model

  attr_accessor :password, :confirm_password, :reset_token

  validates_length_of :password, minimum: User::MIN_PASSWORD_LENGTH
  validate :verify_password_confirmation
  validate :token_freshness

  def user
    @user ||= User.find_by_password_reset_token(reset_token)
  end

  def reset_password
    if valid?
      user.update(password: password)
      user.reset_password_reset_fields
      true
    else
      false
    end
  end

  private
  def verify_password_confirmation
    unless confirm_password == password
      errors.add(:password_confirmation, "does not match password")
    end
  end

  def token_freshness
    if user.password_reset_token_expired?
      errors.add(:password, "reset token has expired")
    end
  end
end