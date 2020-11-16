class SidebarComponent < ApplicationComponent
  def initialize(headquarter:, user:)
    @headquarter  = headquarter
    @user         = user
  end

  def current_user
    @user
  end

  def headquarters
    policy_scope Headquarter
  end
end
