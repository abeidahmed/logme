class Invitation::Mailer::Deliver
  def initialize(user:, object:)
    @user   = user
    @object = object
  end

  def deliver_invitation
    if user_member_of_applog?
      send_invitation
    else
      prepare_user_boarding
    end
  end

  private
  attr_reader :user, :object

  def user_member_of_applog?
    user.persisted?
  end

  def prepare_user_boarding
    user.set_password_reset_fields
    send_invitation(new_user: true)
  end

  def send_invitation(new_user: false)
    HqMembershipMailer.invite(user, object, new_user: new_user).deliver
  end
end