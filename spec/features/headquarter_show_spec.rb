require "rails_helper"

RSpec.feature "HeadquarterShows", type: :feature do
  context "when the user is a permanent headquarter member" do
    let(:hq_membership) { create(:hq_membership) }
    let(:headquarter) { hq_membership.headquarter }

    it "should show the page" do
      sign_in(user: hq_membership.user)
      visit app_headquarter_url(headquarter)

      expect(current_url).to eq(app_headquarter_url(headquarter))
      within ".actionable" do
        expect(page).to have_text(headquarter.name)
      end
    end
  end
end
