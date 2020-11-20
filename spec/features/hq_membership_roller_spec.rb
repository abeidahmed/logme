require "rails_helper"

RSpec.feature "HqMembershipRollers", type: :feature do
  let(:headquarter) { create(:headquarter) }
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }

  it "should promote to owner" do
    add_users_to_headquarter(first_user: user, second_user: another_user)

    expect(last_user).to have_text(another_user.email)
    find(".card__option-confirm--primary").click

    expect(page).to have_content("Promoted #{another_user.name} to owner")
  end

  it "should demote to member" do
    add_users_to_headquarter(first_user: user, second_user: another_user, second_user_role: "owner")

    expect(last_user).to have_text(another_user.email)
    find(".card__option-confirm--danger").click

    expect(page).to have_content("Demoted #{another_user.name} to member")
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
end
