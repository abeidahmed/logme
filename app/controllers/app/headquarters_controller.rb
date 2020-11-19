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

    redirect_to app_hq_invitation_url(membership) if invitation_pending?
  end

  private
  def headquarter_params
    params.require(:headquarter).permit(:name, :description)
  end

  def membership
    current_user.find_headquarter_membership(@headquarter)
  end

  def invitation_pending?
    current_user.headquarter_invite_pending?(@headquarter)
  end
end
