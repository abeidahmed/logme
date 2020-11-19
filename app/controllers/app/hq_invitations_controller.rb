class App::HqInvitationsController < App::ApplicationController
  layout "slate", only: %i(show)

  def show
    @hq_membership = HqMembership.find(params[:id])
    authorize @hq_membership
  end
end
