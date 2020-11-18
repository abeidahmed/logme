class App::ProjectMembershipsController < App::ApplicationController
  def index
    @project              = Project.find(params[:project_id])
    @project_memberships  = policy_scope(@project, policy_scope_class: ProjectMembershipPolicy::Scope)
  end
end
