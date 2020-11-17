require "rails_helper"

RSpec.feature "HqMembershipLists", type: :feature do
  context "being a pemanent memeber of the headquarter" do
    let(:hq_membership) { create(:hq_membership) }

    it "should list all the members within the headquarter" do
      sign_in(user: hq_membership.user)
      visit app_headquarter_hq_memberships_url(hq_membership.headquarter)

      expect(page).to have_content(hq_membership.user.email)
    end
  end
end
