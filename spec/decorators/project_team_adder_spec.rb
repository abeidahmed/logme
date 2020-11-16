require "rails_helper"

RSpec.describe "ProjectTeamAdder" do
  context "when invited is set as true" do
    let(:project) { create(:project) }
    let(:user) { create(:user) }

    it "should set invitation fields to true" do
      team = ProjectTeamAdder.new(project: project, user: user, invited: true)
      team.save
      membership = project.project_memberships.first

      expect(membership.invitation_accepted).to be_falsy
      expect(membership.join_date).to be_nil
    end
  end

  context "when invited is not mentioned" do
    let(:project) { create(:project) }
    let(:user) { create(:user) }

    it "should set invitation fields to false" do
      team = ProjectTeamAdder.new(project: project, user: user)
      team.save
      membership = project.project_memberships.first

      expect(membership.invitation_accepted).to be_truthy
      expect(membership.join_date).to_not be_nil
    end
  end
end