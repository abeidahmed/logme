require "rails_helper"

RSpec.describe "App::HqMemberships", type: :request do
  describe "#create" do
    context "when the user is a member of applog but not a member of headquarter" do
      let(:user) { create(:user) }
      let(:hq_membership) { create(:hq_membership, :owner) }
      let(:headquarter) { hq_membership.headquarter }
      before do
        login(hq_membership.user)
        post app_headquarter_hq_memberships_url(headquarter), params: {
          name: user.name,
          email: user.email.upcase,
          role: "member"
        }
      end

      it "should invite the user" do
        last_membership = headquarter.hq_memberships.unscoped.last
        expect(last_membership.user.email).to eq(user.email)
        expect(last_membership.join_date).to be_nil
        expect(last_membership.invitation_accepted).to be_falsy
      end

      it "should send an invitation email" do
        expect(last_email.subject).to eq("You have an invitation to #{headquarter.name}")
      end

      it "should not set password reset fields" do
        last_membership = headquarter.hq_memberships.unscoped.last
        expect(last_membership.user.password_reset_token).to be_nil
        expect(last_membership.user.password_reset_sent_at).to be_nil
      end
    end

    context "when the user is not a member of applog and not a member of headquarter" do
      let(:user) { build(:user) }
      let(:hq_membership) { create(:hq_membership, :owner) }
      let(:headquarter) { hq_membership.headquarter }
      before do
        login(hq_membership.user)
        post app_headquarter_hq_memberships_url(headquarter), params: {
          name: user.name,
          email: user.email,
          role: "member"
        }
      end

      it "should create the user" do
        expect(User.last.email).to eq(user.email)
      end

      it "should invite the user" do
        expect(headquarter.hq_memberships.unscoped.last.user.email).to eq(user.email)
      end

      it "should set password reset fields" do
        expect(User.last.password_reset_token).to_not be_nil
        expect(User.last.password_reset_sent_at).to_not be_nil
      end

      it "should send an invitation email" do
        expect(last_email.encoded).to match(/noticed/)
      end
    end

    context "when the user is invited by a member of headquarter" do
      let(:user) { create(:user) }
      let(:hq_membership) { create(:hq_membership, role: "member") }
      let(:headquarter) { hq_membership.headquarter }
      before do
        login(hq_membership.user)
        post app_headquarter_hq_memberships_url(headquarter), params: {
          name: user.name,
          email: user.email,
          role: "owner"
        }
      end

      it "should invite the user as a member" do
        expect(headquarter.hq_memberships.last.role).to eq("member")
      end
    end

    context "when the invite request is invalid" do
      let(:hq_membership) { create(:hq_membership, :owner) }
      let(:headquarter) { hq_membership.headquarter }
      let(:user) { hq_membership.user }
      before do
        login(user)
        post app_headquarter_hq_memberships_url(headquarter), params: { email: "helloworld" }
      end

      it "should not invite the user" do
        expect(headquarter.hq_memberships.last.user.email).to eq(user.email)
      end

      it "should not sent the email" do
        expect(last_email).to be_nil
      end

      it "should return error" do
        expect(json[:errors].keys).to match_array([:email, :name])
      end

      include_examples "bad_request"
    end

    context "when the member is already on the headquarter" do
      let(:hq_membership) { create(:hq_membership, :owner) }
      let(:headquarter) { hq_membership.headquarter }
      let(:user) { hq_membership.user }
      before do
        login(user)
        post app_headquarter_hq_memberships_url(headquarter), params: {
          name: user.name,
          email: user.email,
          role: "member"
        }
      end

      it "should return error" do
        expect(json[:errors].keys).to match_array([:user])
      end

      include_examples "bad_request"
    end
  end

  describe "#update" do
    let(:headquarter) { create(:headquarter) }
    let(:hq_membership) { create(:hq_membership, :owner, headquarter: headquarter) }

    context "when the user is an owner" do
      let(:another_membership) { create(:hq_membership, :owner, headquarter: headquarter) }
      before do
        begin_process_for(another_membership)
      end

      it "should demote the owner to member" do
        expect(another_membership.reload.role).to eq("member")
      end
    end

    context "when the user is a member" do
      let(:another_membership) { create(:hq_membership, headquarter: headquarter) }
      before do
        begin_process_for(another_membership)
      end

      it "should promote the member to an owner" do
        expect(another_membership.reload.role).to eq("owner")
      end
    end

    def begin_process_for(user)
      login(hq_membership.user)
      patch app_hq_membership_url(user), params: nil
    end
  end

  describe "#destroy" do
    context "when the deleter is the owner" do
      let(:headquarter) { create(:headquarter) }
      let(:hq_membership) { create(:hq_membership, :owner, headquarter: headquarter) }
      let(:another_membership) { create(:hq_membership, headquarter: headquarter) }
      before do
        login(hq_membership.user)
        delete app_hq_membership_url(another_membership)
      end

      it "should remove the user" do
        expect { HqMembership.find(another_membership.id) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context "when the deleter is the current_user" do
      let(:hq_membership) { create(:hq_membership) }
      before do
        login(hq_membership.user)
        delete app_hq_membership_url(hq_membership)
      end

      it "should exit from the HQ" do
        expect { HqMembership.find(hq_membership.id) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context "when there is only one owner in the HQ" do
      let(:headquarter) { create(:headquarter) }
      let(:hq_membership) { create(:hq_membership, :owner, headquarter: headquarter) }
      let(:another_membership) { create(:hq_membership, headquarter: headquarter) }
      before do
        login(hq_membership.user)
        delete app_hq_membership_url(hq_membership)
      end

      it "should not exit the owner" do
        expect(HqMembership.find(hq_membership.id)).to be_present
      end
    end

    context "when there are two owners" do
      let(:headquarter) { create(:headquarter) }
      let(:user) { create(:user) }
      let(:another_user) { create(:user) }
      before do
        membership = HeadquarterTeamAdder.new(user: user, headquarter: headquarter, role: "owner").save
        HeadquarterTeamAdder.new(user: another_user, headquarter: headquarter, role: "owner").save
        login(user)
        delete app_hq_membership_url(membership)
      end

      it "should exit from the HQ" do
        expect { HqMembership.find(user.hq_memberships.first) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
