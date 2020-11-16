class HeadquarterPolicy < ApplicationPolicy
  def create?
    user
  end

  def show?
    user.has_headquarter_membership?(record)
  end
end
