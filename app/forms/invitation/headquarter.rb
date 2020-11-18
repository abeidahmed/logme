class Invitation::Headquarter
  include ActiveModel::Model

  attr_accessor :name, :email, :role, :headquarter, :current_user

  validates_presence_of :email, :name
  validates_length_of :email, :name, maximum: 255
  validates_format_of :email, with: User::VALID_EMAIL_REGEX
  validate :member_uniqueness

  def user
    @user ||= User.create_with(
      password: SecureRandom.urlsafe_base64,
      name: name
    ).find_or_initialize_by(email: user_email)
  end

  def save
    if valid?
      Invitation::Mailer::Deliver.new(user: user, object: headquarter).deliver_invitation
      persist_user_and_add_to_headquarter
      true
    else
      false
    end
  end

  private
  def persist_user_and_add_to_headquarter
    HeadquarterTeamAdder.new(user: user, headquarter: headquarter, role: user_role, invited: true).save
  end

  def member_uniqueness
    errors.add(:user, "is already on the HQ") if headquarter.hq_memberships.exists?(user_id: user.id)
  end

  def user_email
    email.downcase
  end

  def user_role
    return "member" unless current_user.headquarter_owner?(headquarter)
    role
  end
end