class App::ProjectsController < App::ApplicationController
  def new
    @headquarter  = Headquarter.find(params[:headquarter_id])
    @project      = @headquarter.projects.build
    authorize @headquarter
  end

  def create
    headquarter = Headquarter.find(params[:headquarter_id])
    authorize headquarter, policy_class: ProjectPolicy

    project       = headquarter.projects.build(project_params)
    project_team  = ProjectTeamAdder.new(project: project, user: current_user)

    if project_team.save
      redirect_to app_headquarter_url(headquarter), success: "#{project.name} created"
    else
      render json: { errors: project.errors }, status: :bad_request
    end
  end

  def show
    @project = Project.find(params[:id])
    authorize @project
  end

  private
  def project_params
    params.require(:project).permit(:name, :url, :subdomain, :description)
  end
end
