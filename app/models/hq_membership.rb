class HqMembership < ApplicationRecord
  include Filterable

  belongs_to :user
  belongs_to :headquarter

  scope :pending_members, -> { where(invitation_accepted: false) }
  scope :members_with_role, ->(role) { where(role: role) }

  enum role: { member: "member", owner: "owner" }

  validates_uniqueness_of :user, case_sensitive: false, scope: :headquarter_id, message: "is already on the HQ"

  delegate :name, :email, to: :user
end
