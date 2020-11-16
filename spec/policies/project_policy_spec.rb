require "rails_helper"

RSpec.describe ProjectPolicy, type: :policy do
  let(:headquarter) { create(:headquarter) }
  let(:user) { create(:user) }

  subject { described_class.new(user, headquarter) }

  include_examples "being_a_visitor"

  context "being an owner of the headquarter" do
    before do
      team = HeadquarterTeamAdder.new(user: user, headquarter: headquarter, role: "owner")
      team.save
    end

    it { is_expected.to permit_actions(%i(create)) }
  end

  context "being a member of the headquarter" do
    before do
      team = HeadquarterTeamAdder.new(user: user, headquarter: headquarter)
      team.save
    end

    it { is_expected.to permit_actions(%i(create)) }
  end

  context "being a spectator of the headquarter" do
    before do
      team = HeadquarterTeamAdder.new(user: user, headquarter: headquarter, invited: true)
      team.save
    end

    it { is_expected.to forbid_actions(%i(create)) }
  end
end
