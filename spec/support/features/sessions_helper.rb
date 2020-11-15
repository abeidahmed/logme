module Features
  module SessionsHelper
    def sign_up(name: "John Doe", email: "hello@exa.com", password: "secrettt")
      visit new_user_url
      fill_in "user[name]", with: "John Doe"
      fill_in "user[email]", with: "hello@example.com"
      fill_in "user[password]", with: "secrettt"
      click_button "Join"
    end

    def sign_in(user: nil)
      user = user || create(:user)
      visit new_session_url
      fill_in "email", with: user.email
      fill_in "password", with: user.password
      click_button "Sign"
    end
  end
end