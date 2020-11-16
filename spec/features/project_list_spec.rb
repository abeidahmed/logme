require "rails_helper"

RSpec.feature "ProjectLists", type: :feature do
  context "when the user is the owner of the headquarter" do
    let(:hq_membership) { create(:hq_membership, :owner) }
    let(:user) { hq_membership.user }
    let(:headquarter) { hq_membership.headquarter }
    let(:project) { create(:project, name: "hello owner", headquarter: headquarter) }

    it "should list all the projects" do
      initialize_page_visit(project: project, user: user, headquarter: headquarter)

      within ".grid__three_centered" do
        expect(page).to have_text("hello owner")
      end
    end
  end

  context "when the user is a member" do
    let(:hq_membership) { create(:hq_membership) }
    let(:user) { hq_membership.user }
    let(:headquarter) { hq_membership.headquarter }
    let(:project) { create(:project, name: "hello member", headquarter: headquarter) }
    let(:project_2) { create(:project, name: "hello member 2", headquarter: headquarter) }

    it "should only see the projects which the user is part of" do
      initialize_page_visit(project: project, user: user, headquarter: headquarter)

      within ".grid__three_centered" do
        expect(page).to have_text("hello member")
        expect(page).to_not have_text("hello member 2")
      end
    end
  end
end

def initialize_page_visit(project:, user:, headquarter:)
  ProjectTeamAdder.new(project: project, user: user).save
  sign_in(user: user)
  visit app_headquarter_projects_url(headquarter)
end
