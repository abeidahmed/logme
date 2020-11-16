require "rails_helper"

RSpec.describe HeadquarterPolicy, type: :policy do
  let(:user) { create(:user) }
  let(:headquarter) { Headquarter.new }

  subject { described_class.new(user, headquarter) }

  include_examples "being_a_visitor"

  context "being a logged in user only" do
    it { is_expected.to permit_actions(%i(create)) }
  end

  context "being an owner" do
    let(:headquarter) { create(:headquarter) }
    before do
      team = HeadquarterTeamAdder.new(headquarter: headquarter, user: user, role: "owner")
      team.save
    end

    it { is_expected.to permit_actions(%i(show)) }
  end

  context "being a member" do
    let(:headquarter) { create(:headquarter) }
    before do
      team = HeadquarterTeamAdder.new(headquarter: headquarter, user: user)
      team.save
    end

    it { is_expected.to permit_actions(%i(show)) }
  end
end
