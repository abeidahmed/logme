class ProjectPolicy < ApplicationPolicy
  def create?
    good_headquarter_member?
  end
end
