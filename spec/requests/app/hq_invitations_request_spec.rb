require "rails_helper"

RSpec.describe "App::HqInvitations", type: :request do
  describe "#update" do
    context "when the invitation is pending" do
      let(:hq_membership) { create(:hq_membership, :pending) }
      before do
        login(hq_membership.user)
        patch app_hq_invitation_url(hq_membership), params: nil
      end

      it "should accept the invitation" do
        hq_membership.reload
        expect(hq_membership.invitation_accepted).to be_truthy
        expect(hq_membership.join_date).to_not be_nil
      end
    end
  end

  describe "#destroy" do
    context "when the invitation is pending" do
      let(:hq_membership) { create(:hq_membership, :pending) }
      before do
        login(hq_membership.user)
        delete app_hq_invitation_url(hq_membership)
      end

      it "should decline the invitation" do
        expect { HqMembership.find(hq_membership.id) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
