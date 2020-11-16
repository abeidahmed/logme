require "rails_helper"

RSpec.describe "HeadquarterTeamAdder" do
  context "when role is not mentioned" do
    let(:headquarter) { create(:headquarter) }
    let(:user) { create(:user) }

    it "should set the role as member" do
      team = HeadquarterTeamAdder.new(headquarter: headquarter, user: user)
      team.save

      expect(headquarter.hq_memberships.first.role).to eq("member")
    end
  end

  context "when invited is set as true" do
    let(:headquarter) { create(:headquarter) }
    let(:user) { create(:user) }

    it "should set invitation fields to true" do
      team = HeadquarterTeamAdder.new(headquarter: headquarter, user: user, invited: true)
      team.save
      membership = headquarter.hq_memberships.first

      expect(membership.invitation_accepted).to be_falsy
      expect(membership.join_date).to be_nil
    end
  end

  context "when invited is not mentioned" do
    let(:headquarter) { create(:headquarter) }
    let(:user) { create(:user) }

    it "should set invitation fields to false" do
      team = HeadquarterTeamAdder.new(headquarter: headquarter, user: user)
      team.save
      membership = headquarter.hq_memberships.first

      expect(membership.invitation_accepted).to be_truthy
      expect(membership.join_date).to_not be_nil
    end
  end
end