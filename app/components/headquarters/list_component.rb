class Headquarters::ListComponent < ApplicationComponent
  def initialize(user:)
    @user = user
  end

  def current_user
    @user
  end

  def headquarters
    policy_scope Headquarter
  end
end
