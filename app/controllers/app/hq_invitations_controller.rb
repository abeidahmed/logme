class App::HqInvitationsController < App::ApplicationController
  layout "slate", only: %i(show)

  def show
    @hq_membership = HqMembership.find(params[:id])
    authorize @hq_membership
  end

  def update
    hq_membership = HqMembership.find(params[:id])
    authorize hq_membership

    hq_membership.update(join_date: Time.zone.now, invitation_accepted: true)
  end

  def destroy
    hq_membership = HqMembership.find(params[:id])
    authorize hq_membership

    hq_membership.destroy
  end
end
