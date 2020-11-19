require "rails_helper"

RSpec.feature "HqInvitations", type: :feature do
  context "when the accept invitation button is clicked" do
    let(:hq_membership) { create(:hq_membership, :pending) }

    it "should accept the invitation" do
      sign_in(user: hq_membership.user)
      visit app_hq_invitation_url(hq_membership)
      click_button "Accept"

      expect(current_url).to eq(app_headquarter_url(hq_membership.headquarter))
      expect(page).to have_text("part of the HQ")
    end
  end

  context "when the decline invitation button is clicked" do
    let(:hq_membership) { create(:hq_membership, :pending) }

    it "should decline the invitation" do
      sign_in(user: hq_membership.user)
      visit app_hq_invitation_url(hq_membership)
      click_button "Decline"

      expect(current_url).to eq(root_url)
      expect(page).to have_text("declined")
    end
  end
end
