class HqMembership < ApplicationRecord
  belongs_to :user
  belongs_to :headquarter

  enum role: { member: "member", owner: "owner" }

  validates_uniqueness_of :user, case_sensitive: false, scope: :headquarter_id, message: "is already on the HQ"

  delegate :name, :email, to: :user
end
