require "rails_helper"

RSpec.describe HqMembershipPolicy, type: :policy do
  let(:hq_membership) { create(:hq_membership, :owner) }
  let(:user) { hq_membership.user }
  let(:headquarter) { hq_membership.headquarter }

  subject { described_class.new(user, headquarter) }

  include_examples "being_a_visitor"

  context "being an owner" do
    it { is_expected.to permit_actions(%i(create)) }
  end

  context "being a member" do
    let(:hq_membership) { create(:hq_membership) }

    it { is_expected.to permit_actions(%i(create)) }
  end

  context "being a spectator" do
    let(:hq_membership) { create(:hq_membership, :pending_owner) }

    it { is_expected.to forbid_actions(%i(create)) }
  end
end