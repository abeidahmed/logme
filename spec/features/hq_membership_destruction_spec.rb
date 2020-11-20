require "rails_helper"

RSpec.feature "HqMembershipDestructions", type: :feature do
  let(:headquarter) { create(:headquarter) }

  it "should exit out of HQ" do
    hq_membership = create(:hq_membership)
    sign_in(user: hq_membership.user)
    visit app_headquarter_hq_memberships_url(hq_membership.headquarter)

    expect(last_user).to have_text(hq_membership.email)
    find(".card__option-confirm--danger").click

    expect(current_url).to eq(app_headquarters_url)
    expect(page).to have_content("good reasons")
  end

  it "should remove other users" do
    user = create(:user)
    another_user = create(:user)
    add_users_to_headquarter(first_user: user, second_user: another_user)

    expect(last_user).to have_text(another_user.email)
    within last_user do
      remove_button.click
    end

    expect(current_url).to eq(app_headquarter_hq_memberships_url(headquarter))
    expect(page).to have_content("Removed #{another_user.name}")
  end

  it "should show error when the user is the only owner" do
    hq_membership = create(:hq_membership, :owner)
    sign_in(user: hq_membership.user)
    visit app_headquarter_hq_memberships_url(hq_membership.headquarter)

    first_user = page.all(:css, ".card").first
    expect(first_user).to have_text(hq_membership.name)

    within first_user do
      page.all(:css, ".card__option-confirm--danger").last.click
    end

    expect(page).to have_text("only owner")
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

  def remove_button
    page.all(:css, ".card__option-confirm--danger").last
  end
end
