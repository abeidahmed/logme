require "rails_helper"

RSpec.feature "HeadquarterNews", type: :feature do
  context "when the user is logged in" do
    let(:hq_membership) { create(:hq_membership) }

    it "should be able to create headquarter" do
      sign_in(user: hq_membership.user)
      visit app_headquarter_url(hq_membership.headquarter)
      within "#headquarter_new" do
        fill_in "headquarter[name]", with: "hello hq"
        fill_in "headquarter[description]", with: "hq description"
        click_button "new"
      end

      expect(current_url).to eq(app_headquarter_url(Headquarter.last.id))
      expect(page).to have_text("hello hq")
    end
  end
end
