class HqMembershipPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.has_headquarter_membership?(scope) && user.headquarter_invite_accepted?(scope)
        scope.hq_memberships.includes(:user)
      end
    end
  end
end
