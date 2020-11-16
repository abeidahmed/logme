class HeadquarterPolicy < ApplicationPolicy
  def create?
    user
  end
end
