require "rails_helper"

RSpec.feature "HqMembershipLists", type: :feature do
  let(:headquarter) { create(:headquarter) }

  context "when the user is a pemanent member of the headquarter" do
    let(:hq_membership) { create(:hq_membership) }

    it "should list all the members within the headquarter" do
      sign_in(user: hq_membership.user)
      visit app_headquarter_hq_memberships_url(hq_membership.headquarter)

      expect(page).to have_content(hq_membership.user.email)
    end
  end

  context "when the user is only a member" do
    let(:user) { create(:user) }
    let(:another_user) { create(:user) }

    it "should not see promote or remove from HQ options" do
      add_users_to_headquarter(first_user: user, second_user: another_user, first_user_role: "member")

      expect(last_user).to have_text(another_user.email)
      restrict_all_options
    end
  end

  context "when the user is an owner and other user is a member" do
    let(:user) { create(:user) }
    let(:another_user) { create(:user) }

    it "should see promote or remove from HQ options for other members' card" do
      add_users_to_headquarter(first_user: user, second_user: another_user)

      expect(last_user).to have_text(another_user.email)
      expect(last_user).not_to have_text("Demote")
      expect(last_user).to have_text("Promote")
      expect(last_user).to have_text("Remove")
    end
  end

  context "when the user is the current_user" do
    let(:hq_membership) { create(:hq_membership, :owner, headquarter: headquarter) }

    it "should see exit from HQ option" do
      sign_in(user: hq_membership.user)
      visit app_headquarter_hq_memberships_url(headquarter)

      expect(last_user).to have_text("Exit")
      restrict_all_options
    end
  end

  context "when the other user is an owner too" do
    let(:user) { create(:user) }
    let(:another_user) { create(:user) }

    it "should see demote option" do
      add_users_to_headquarter(first_user: user, second_user: another_user, second_user_role: "owner")

      expect(last_user).to have_text(another_user.email)
      expect(last_user).to have_text("Demote")
      expect(last_user).to have_text("Remove")
      expect(last_user).not_to have_text("Promote")
    end
  end

  def add_users_to_headquarter(first_user:, second_user:, first_user_role: "owner", second_user_role: "member")
    HeadquarterTeamAdder.new(user: first_user, headquarter: headquarter, role: first_user_role).save
    HeadquarterTeamAdder.new(user: second_user, headquarter: headquarter, role: second_user_role).save
    sign_in(user: first_user)
    visit app_headquarter_hq_memberships_url(headquarter)
  end

  def last_user
    page.all(:css, ".card").last
  end

  def restrict_all_options
    expect(last_user).not_to have_text("Promote")
    expect(last_user).not_to have_text("Demote")
    expect(last_user).not_to have_text("Remove")
  end
end
