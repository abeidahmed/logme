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
      user.set_password_reset_fields if user.new_record?
      user.save
      invite_to_headquarter
      true
    else
      false
    end
  end

  private
  def invite_to_headquarter
    HeadquarterTeamAdder.new(user: user, headquarter: headquarter, role: user_role, invited: true).save
  end

  def member_uniqueness
    if headquarter.hq_memberships.exists?(user_id: user.id)
      errors.add(:user, "is already on the HQ")
    end
  end

  def user_email
    email.downcase
  end

  def user_role
    return "member" unless current_user.headquarter_owner?(headquarter)
    role
  end
end