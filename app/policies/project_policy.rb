class ProjectPolicy < ApplicationPolicy
  def create?
    good_headquarter_member?
  end

  def show?
    user.has_project_membership?(record) || good_owner?(object: record.headquarter)
  end

  class Scope < Scope
    def resolve
      if good_owner?
        scope.projects.all
      else
        scope.projects.includes(:project_memberships).where(project_memberships: { user_id: user.id })
      end
    end

    private
    def good_owner?
      user.has_headquarter_membership?(scope) &&
        user.headquarter_invite_accepted?(scope) &&
        user.headquarter_owner?(scope)
    end
  end
end
