class HeadquarterPolicy < ApplicationPolicy
  def create?
    user
  end

  class Scope < Scope
    def resolve
      scope.includes(:hq_memberships).where(hq_memberships: { user_id: user.id })
    end
  end
end
