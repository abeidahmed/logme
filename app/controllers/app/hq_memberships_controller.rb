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
end
