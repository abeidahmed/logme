require "rails_helper"

RSpec.feature "HeadquarterLists", type: :feature do
  context "when the user is logged in" do
    let(:hq_membership) { create(:hq_membership) }

    it "should list all the headquarters that the user is part of" do
      sign_in(user: hq_membership.user)
      visit app_headquarters_url

      within ".grid__three_centered" do
        expect(page).to have_text(hq_membership.headquarter.name)
      end
    end
  end

  context "when the user is only a member of headquarter" do
    let(:hq_membership) { create(:hq_membership) }

    it "should not see the edit or delete link" do
      sign_in(user: hq_membership.user)
      visit app_headquarters_url

      within ".card" do
        expect(page).not_to have_text("Edit")
        expect(page).not_to have_text("Delete")
      end
    end
  end

  context "when the user is an owner of the headquarter" do
    let(:hq_membership) { create(:hq_membership, :owner) }

    it "should not see the edit or delete link" do
      sign_in(user: hq_membership.user)
      visit app_headquarters_url

      within ".card" do
        expect(page).to have_text("Edit")
        expect(page).to have_text("Delete")
      end
    end
  end
end
