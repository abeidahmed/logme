class HeadquarterTeamAdder
  def initialize(headquarter:, user:, role: "member", invited: false)
    @headquarter  = headquarter
    @user         = user
    @role         = role
    @invited      = invited
  end

  attr_reader :headquarter, :user, :role, :invited

  def save
    headquarter.save && add_user_to_team
  end

  private
  def add_user_to_team
    headquarter.hq_memberships.create!(
      user: user,
      role: role,
      join_date: invited ? nil : Time.zone.now,
      invitation_accepted: invited ? false : true
    )
  end
end