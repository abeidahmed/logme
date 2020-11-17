require "rails_helper"

RSpec.feature "ProjectNews", type: :feature do
  context "when the user is a member of the headquarter" do
    let(:hq_membership) { create(:hq_membership) }

    it "should create the project" do
      sign_in(user: hq_membership.user)
      visit new_app_headquarter_project_url(hq_membership.headquarter)

      fill_in "project[name]", with: "hello project"
      fill_in "project[url]", with: "https://google.com"
      fill_in "project[subdomain]", with: "helloworld"
      click_button "new"

      expect(current_url).to eq(app_headquarter_projects_url(hq_membership.headquarter))
      expect(page).to have_text("hello project")
      expect(page).to have_text("hello project created")
    end
  end
end