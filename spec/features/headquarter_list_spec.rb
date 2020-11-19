require "rails_helper"

RSpec.feature "HeadquarterLists", type: :feature do
  context "when the user is logged in" do
    let(:hq_membership) { create(:hq_membership) }

    it "should all the headquarters that the user is part of" do
      sign_in(user: hq_membership.user)
      visit app_headquarters_url

      within ".grid__three_centered" do
        expect(page).to have_text(hq_membership.headquarter.name)
      end
    end
  end
end
