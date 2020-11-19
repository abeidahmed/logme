require "rails_helper"

RSpec.feature "SignOuts", type: :feature do
  context "when the signout button is clicked" do
    it "should sign out the user" do
      sign_in
      visit app_headquarters_url
      within ".app__header" do
        find(".avatar__container").click
        click_link "Sign out"
      end

      expect(current_url).to eq(new_session_url)
      expect(page).to have_text("logged")
    end
  end
end
