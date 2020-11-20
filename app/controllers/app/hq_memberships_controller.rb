class App::HqMembershipsController < App::ApplicationController
  def index
    @headquarter    = Headquarter.find(params[:headquarter_id])
    @hq_memberships = policy_scope(@headquarter, policy_scope_class: HqMembershipPolicy::Scope).
      filter_by_role(params[:role])
  end

  def create
    headquarter = Headquarter.find(params[:headquarter_id])
    authorize headquarter, policy_class: HqMembershipPolicy

    member = Invitation::Headquarter.new(
      headquarter: headquarter,
      email: params[:email],
      name: params[:name],
      role: params[:role],
      current_user: current_user
    )

    if member.save
      redirect_to app_headquarter_hq_memberships_url(headquarter), success: "Invitation sent to #{member.email}"
    else
      render json: { errors: member.errors }, status: :bad_request
    end
  end

  def update
    hq_membership = HqMembership.find(params[:id])
    authorize hq_membership, :roller?

    if hq_membership.owner?
      hq_membership.member!
      flash[:success] = "Demoted #{hq_membership.name} to member"
    else
      hq_membership.owner!
      flash[:success] =  "Promoted #{hq_membership.name} to owner"
    end
    redirect_back fallback_location: app_headquarter_hq_memberships_url(hq_membership.headquarter)
  end

  def destroy
    hq_membership = HqMembership.find(params[:id])
    authorize hq_membership

    persisted_owner = Tombstone::HqMembership.new(hq_membership: hq_membership, current_user: current_user)
    if persisted_owner.needs_partner_owner?
      redirect_back fallback_location: app_headquarter_hq_memberships_url(hq_membership.headquarter)
      flash[:alert] = "You are the only owner in the HQ, promote someone before you leave"
      return
    end

    hq_membership.destroy
    if current_user == hq_membership.user
      redirect_to app_headquarters_url, success: "Exited for good reasons"
    else
      flash[:success] = "Removed #{hq_membership.name} for good reasons"
      redirect_back fallback_location: app_headquarter_hq_memberships_url(hq_membership.headquarter)
    end
  end
end
