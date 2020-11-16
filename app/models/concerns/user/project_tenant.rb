class User
  module ProjectTenant
    def has_project_membership?(project)
      project_memberships.exists?(project_id: project.id)
    end
  end
end