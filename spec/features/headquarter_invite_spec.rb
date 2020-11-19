require "rails_helper"

RSpec.feature "HeadquarterInvites", type: :feature do
  context "when the invitation form is filled correctly" do
    let(:hq_membership) { create(:hq_membership) }

    it "should send an invitation" do
      sign_in(user: hq_membership.user)
      visit app_headquarter_hq_memberships_url(hq_membership.headquarter)
      fill_in "name", with: "John Doe"
      fill_in "email", with: "invite@example.com"

      click_button "invite"
      expect(page).to have_text("John Doe")
      expect(page).to have_text("sent to")
    end
  end
end
