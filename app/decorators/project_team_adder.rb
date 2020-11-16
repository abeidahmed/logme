class ProjectTeamAdder
  def initialize(project:, user:, invited: false)
    @project  = project
    @user     = user
    @invited  = invited
  end

  attr_reader :project, :user, :invited

  def save
    project.save && add_user_to_team
  end

  private
  def add_user_to_team
    project.project_memberships.create!(
      user: user,
      join_date: invited ? nil : Time.zone.now,
      invitation_accepted: invited ? false : true
    )
  end
end