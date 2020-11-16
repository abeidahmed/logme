require "rails_helper"

RSpec.feature "ProjectLists", type: :feature do
  context "when project index page is visited as a member of headquarter" do
    let(:hq_membership) { create(:hq_membership) }
    let(:headquarter) { hq_membership.headquarter }
    let(:user) { hq_membership.user }
    before do
      sign_in(user: user)
      visit app_headquarter_projects_url(headquarter)
    end

    it "should list all the projects within the headquarter" do
      expect(page).to have_text("Projects")
    end
  end
end
