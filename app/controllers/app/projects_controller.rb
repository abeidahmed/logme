class App::ProjectsController < App::ApplicationController
  def index
    @headquarter = Headquarter.find(params[:headquarter_id])
    @projects = policy_scope @headquarter, policy_scope_class: ProjectPolicy::Scope
  end

  def create
    headquarter = Headquarter.find(params[:headquarter_id])
    authorize headquarter, policy_class: ProjectPolicy

    project       = headquarter.projects.build(project_params)
    project_team  = ProjectTeamAdder.new(project: project, user: current_user)

    if project_team.save
      # redirect_to app_headquarter_url(hq)
    else
      render json: { errors: project.errors }, status: :bad_request
    end
  end

  private
  def project_params
    params.require(:project).permit(:name, :url, :subdomain, :description)
  end
end
