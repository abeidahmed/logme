require "rails_helper"

RSpec.describe "App::Headquarters", type: :request do
  describe "#create" do
    let(:user) { create(:user) }
    context "when the post request is valid" do
      before do
        login(user)
        post app_headquarters_url, params: { headquarter: attributes_for(:headquarter) }
      end

      it "should create the headquarter" do
        expect(Headquarter.all.size).to eq(1)
      end

      it "should add the current_user to the hq_membership as owner" do
        users = Headquarter.first.users
        hq_membership = HqMembership.first
        expect(users.count).to eq(1)
        expect(hq_membership.role).to eq("owner")
        expect(hq_membership.invitation_accepted).to be_truthy
      end
    end

    context "when the name is not provided" do
      before do
        login(user)
        post app_headquarters_url, params: { headquarter: attributes_for(:headquarter).except(:name) }
      end

      it "should not create the headquarter" do
        expect(Headquarter.all.size).to be_zero
      end

      it "should return error" do
        expect(json.dig(:errors, :name)).to_not be_nil
      end

      include_examples "bad_request"
    end
  end
end
