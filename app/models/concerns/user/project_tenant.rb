class User
  module ProjectTenant
    def has_project_membership?(project)
      project_memberships.exists?(project_id: project.id)
    end

    def project_invite_accepted?(project)
      find_project_membership(project).invitation_accepted?
    end

    def project_invite_pending?(project)
      !find_project_membership(project).invitation_accepted?
    end

    def find_project_membership(project)
      project_memberships.find_by(project_id: project.id)
    end
  end
end