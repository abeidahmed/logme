require "rails_helper"

RSpec.feature "Signins", type: :feature do
  describe "with valid email and password" do
    it "should login user" do
      sign_in

      expect(current_url).to eq(app_headquarters_url)
      expect(page).to have_content("signed in")
    end
  end

  describe "when the user is already logged in" do
    it "should redirect to app_headquarters_url" do
      sign_in
      visit new_session_url

      expect(current_url).to eq(app_headquarters_url)
    end
  end
end
