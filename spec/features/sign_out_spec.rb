require "rails_helper"

RSpec.feature "SignOuts", type: :feature do
  context "when the signout button is clicked" do
    let(:hq_membership) { create(:hq_membership) }

    it "should sign out the user" do
      sign_in(user: hq_membership.user)
      visit app_headquarter_url(hq_membership.headquarter)
      within ".app__header" do
        find(".avatar__container").click
        click_link "Sign out"
      end

      expect(current_url).to eq(new_session_url)
      expect(page).to have_text("logged")
    end
  end
end
