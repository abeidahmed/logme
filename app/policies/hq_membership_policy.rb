class HqMembershipPolicy < ApplicationPolicy
  def create?
    good_headquarter_member?
  end

  def show?
    good_candidate_for_joining?
  end

  def update?
    show?
  end

  def destroy?
    show?
  end

  class Scope < Scope
    def resolve
      if user.has_headquarter_membership?(scope) && user.headquarter_invite_accepted?(scope)
        scope.hq_memberships.includes(:user)
      end
    end
  end

  private
  def good_candidate_for_joining?
    user.has_headquarter_membership?(record.headquarter) && user.headquarter_invite_pending?(record.headquarter)
  end
end
