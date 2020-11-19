class HeadquarterPolicy < ApplicationPolicy
  def create?
    user
  end

  def show?
    user.has_headquarter_membership?(record)
  end

  def update?
    good_owner?
  end

  class Scope < Scope
    def resolve
      scope.includes(:hq_memberships).where(hq_memberships: { user_id: user.id })
    end
  end
end
