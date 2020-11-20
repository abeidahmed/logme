class HqMembershipPolicy < ApplicationPolicy
  def create?
    good_headquarter_member?
  end

  def show?
    is_current_user?
  end

  def update?
    show?
  end

  def destroy?
    good_owner?(object: record.headquarter) || show?
  end

  def roller?
    good_owner?(object: record.headquarter)
  end

  class Scope < Scope
    def resolve
      if user.has_headquarter_membership?(scope) && user.headquarter_invite_accepted?(scope)
        scope.hq_memberships.includes(:user)
      end
    end
  end

  private
  def is_current_user?
    user == record.user
  end
end
