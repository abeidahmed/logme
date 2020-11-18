require "rails_helper"

RSpec.feature "PasswordResets", type: :feature do
  context "when forgot password link is clicked" do
    it "should redirect to new password reset url" do
      visit new_session_url
      click_link "password"

      expect(current_url).to eq(new_password_reset_url)
      expect(page).to have_content("Forgot")
    end
  end

  context "when correct email address is filled" do
    it "should redirect to show password page" do
      user = create(:user)
      visit new_password_reset_url
      fill_in "email", with: user.email
      click_button "reset"

      expect(current_url).to eq(password_reset_url(user))
      expect(page).to have_text(user.email)
    end
  end
end
