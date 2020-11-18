class ProjectMembershipPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if (user.has_project_membership?(scope) && user.project_invite_accepted?(scope)) || good_owner?
        scope.project_memberships.includes(:user)
      end
    end

    private
    def good_owner?
      user.has_headquarter_membership?(scope.headquarter) &&
        user.headquarter_invite_accepted?(scope.headquarter) &&
        user.headquarter_owner?(scope.headquarter)
    end
  end
end
