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

  context "when the password reset token has expired" do
    it "should redirect to new password reset page" do
      user = create(:user, :with_expired_token)
      visit edit_password_reset_url(user.password_reset_token)

      expect(current_url).to eq(new_password_reset_url)
      expect(page).to have_text("expired")
    end
  end

  context "when the user has valid password reset token" do
    it "should reset the password" do
      user = create(:user, :forgot_password)
      visit edit_password_reset_url(user.password_reset_token)
      fill_in "password", with: "helloworld"
      fill_in "confirm_password", with: "helloworld"
      click_button "password"

      expect(current_url).to eq(new_session_url)
      expect(page).to have_text("new password")
    end
  end
end
