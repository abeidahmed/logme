class Headquarter < ApplicationRecord
  has_many :hq_memberships
  has_many :users, through: :hq_memberships
  has_many :projects

  validates_presence_of :name
  validates_length_of :name, maximum: 255
  validates_length_of :description, maximum: 500

  def total_owners
    hq_memberships.members_with_role("owner").size
  end
end