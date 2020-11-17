class App::HqMembershipsController < App::ApplicationController
  def index
    @headquarter    = Headquarter.find(params[:headquarter_id])
    @hq_memberships = policy_scope(@headquarter, policy_scope_class: HqMembershipPolicy::Scope)
  end
end
