class App::HeadquartersController < App::ApplicationController
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

  def show
    @headquarter = Headquarter.find(params[:id])
    authorize @headquarter
  end

  private
  def headquarter_params
    params.require(:headquarter).permit(:name, :description)
  end
end
