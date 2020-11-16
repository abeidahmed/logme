class App::HeadquartersController < App::ApplicationController
  def index
    skip_policy_scope
  end

  def create
    headquarter = Headquarter.new(headquarter_params)
    authorize headquarter

    hq_team = HeadquarterTeamAdder.new(headquarter: headquarter, user: current_user, role: "owner")

    if hq_team.save
      # redirect_to app_headquarters_url
    else
      render json: { errors: headquarter.errors }, status: :bad_request
    end
  end

  private
  def headquarter_params
    params.require(:headquarter).permit(:name, :description)
  end
end
