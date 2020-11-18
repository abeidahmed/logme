class PasswordReset::Initiator
  include ActiveModel::Model

  attr_accessor :email
  delegate :id, to: :user

  validate :presence_of_user

  def user
    @user ||= User.find_by_email(user_email)
  end

  def initialized_reset
    if valid?
      user.set_password_reset_fields
      UserMailer.password_reset(user).deliver
      true
    else
      false
    end
  end

  private
  def presence_of_user
    unless User.exists?(email: user_email)
      errors.add(:invalid, "email address")
    end
  end

  def user_email
    email.downcase
  end
end