class Tombstone::HqMembership
  def initialize(hq_membership:, current_user:)
    @hq_membership  = hq_membership
    @current_user   = current_user
  end

  def needs_partner_owner?
    lone_owner? && current_user_is_headquarter_owner? && is_current_user?
  end

  private
  attr_reader :hq_membership, :current_user

  def current_user_is_headquarter_owner?
    current_user.headquarter_owner?(hq_membership.headquarter)
  end

  def is_current_user?
    current_user == hq_membership.user
  end

  def lone_owner?
    total_owners == 1
  end

  def total_owners
    hq_membership.headquarter.total_owners
  end
end