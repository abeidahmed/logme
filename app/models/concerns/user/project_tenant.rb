class User
  module ProjectTenant
    def has_project_membership?(project)
      project_memberships.exists?(project_id: project.id)
    end

    def project_invite_accepted?(project)
      project_memberships.find_by(project_id: project.id).invitation_accepted?
    end
  end
end