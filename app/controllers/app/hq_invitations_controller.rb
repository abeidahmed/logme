class App::HqInvitationsController < App::ApplicationController
  layout "slate", only: %i(show)

  def show
    @hq_membership = HqMembership.find(params[:id])
    authorize @hq_membership
  end

  def update
    hq_membership = HqMembership.find(params[:id])
    authorize hq_membership

    if hq_membership.update(join_date: Time.zone.now, invitation_accepted: true)
      redirect_to app_headquarter_url(hq_membership.headquarter), success: "Yay! You're now part of the HQ"
    end
  end

  def destroy
    hq_membership = HqMembership.find(params[:id])
    authorize hq_membership

    if hq_membership.destroy
      redirect_to app_headquarters_url, success: "You have declined the invitation"
    end
  end
end
