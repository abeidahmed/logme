require "rails_helper"

RSpec.feature "HqInvitations", type: :feature do
  let(:hq_membership) { create(:hq_membership, :pending) }

  context "when the accept invitation button is clicked" do
    it "should accept the invitation" do
      initialize_page_visit(hq_membership)
      click_button "Accept"

      expect(current_url).to eq(app_headquarter_url(hq_membership.headquarter))
      expect(page).to have_text("part of the HQ")
    end
  end

  context "when the decline invitation button is clicked" do
    it "should decline the invitation" do
      initialize_page_visit(hq_membership)
      click_button "Decline"

      expect(current_url).to eq(app_headquarters_url)
      expect(page).to have_text("declined")
    end
  end

  context "when do it later link is clicked" do
    it "should take me to headquarters url" do
      initialize_page_visit(hq_membership)
      click_link "I'll do it later"

      expect(current_url).to eq(app_headquarters_url)
    end
  end
end

def initialize_page_visit(membership)
  sign_in(user: membership.user)
  visit app_hq_invitation_url(membership)
end