require "rails_helper"

RSpec.describe "App::Projects", type: :request do
  describe "#create" do
    context "being a member of the headquarter" do
      let(:hq_membership) { create(:hq_membership) }
      let(:headquarter) { hq_membership.headquarter }
      before do
        login(hq_membership.user)
        post app_headquarter_projects_url(headquarter), params: { project: attributes_for(:project) }
      end

      it "should create the project" do
        expect(headquarter.projects.size).to eq(1)
      end

      it "should add the current_user to the project team" do
        users = Project.first.users
        project_membership = ProjectMembership.first
        expect(users.size).to eq(1)
        expect(project_membership.join_date).to_not be_nil
        expect(project_membership.invitation_accepted).to be_truthy
      end
    end

    context "when the project attributes are invalid" do
      let(:hq_membership) { create(:hq_membership) }
      let(:headquarter) { hq_membership.headquarter }
      before do
        login(hq_membership.user)
        post app_headquarter_projects_url(headquarter), params: { project: attributes_for(:project).except(:subdomain) }
      end

      it "should not create the project" do
        expect(headquarter.projects.size).to be_zero
      end

      it "should return error" do
        expect(json.dig(:errors, :subdomain)).to_not be_nil
      end

      include_examples "bad_request"
    end
  end
end
