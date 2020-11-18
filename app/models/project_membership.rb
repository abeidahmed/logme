class ProjectMembership < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates_length_of     :job_title, maximum: 255
  validates_uniqueness_of :user, case_sensitive: false, scope: :project_id, message: "is already on the project team"

  delegate :name, :email, to: :user
end
