require "rails_helper"

RSpec.describe HeadquarterPolicy, type: :policy do
  let(:user) { create(:user) }
  let(:headquarter) { create(:headquarter) }

  subject { described_class.new(user, headquarter) }

  include_examples "being_a_visitor"

  context "being a logged in user only" do
    it { is_expected.to permit_actions(%i(create)) }
  end

  context "being an owner" do
    before do
      HeadquarterTeamAdder.new(user: user, headquarter: headquarter, role: "owner").save
    end

    it { is_expected.to permit_actions(%i(show update)) }
  end

  context "being a member" do
    before do
      HeadquarterTeamAdder.new(user: user, headquarter: headquarter, role: "member").save
    end

    it { is_expected.to permit_actions(%i(show)) }
    it { is_expected.to forbid_actions(%i(update)) }
  end

  context "being a spectator" do
    before do
      HeadquarterTeamAdder.new(user: user, headquarter: headquarter, invited: true).save
    end

    it { is_expected.to permit_actions(%i(show)) }
    it { is_expected.to forbid_actions(%i(update)) }
  end
end
