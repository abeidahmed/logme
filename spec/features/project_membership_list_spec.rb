require "rails_helper"

RSpec.feature "ProjectMembershipLists", type: :feature do
  context "being a permanent member of the project team" do
    let(:project_membership) { create(:project_membership) }
    let(:user) { project_membership.user }

    it "should list all the members" do
      sign_in(user: user)
      visit app_project_project_memberships_url(project_membership.project)

      expect(page).to have_text(user.email)
    end
  end

  context "being the owner of the headquarter" do
    let(:hq_membership) { create(:hq_membership, :owner) }
    let(:user) { hq_membership.user }
    let(:project) { create(:project, headquarter: hq_membership.headquarter) }

    it "should list all the members" do
      another_user = create(:user)
      ProjectTeamAdder.new(user: another_user, project: project).save
      sign_in(user: user)
      visit app_project_project_memberships_url(project)

      expect(page).to have_text(another_user.email)
    end
  end
end