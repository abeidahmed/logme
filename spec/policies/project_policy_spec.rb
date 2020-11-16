require "rails_helper"

RSpec.describe ProjectPolicy, type: :policy do
  describe "when headquarter is the subject" do
    let(:user) { create(:user) }
    let(:headquarter) { create(:headquarter) }

    subject { described_class.new(user, headquarter) }

    include_examples "being_a_visitor"

    context "being an owner of the headquarter" do
      before do
        HeadquarterTeamAdder.new(user: user, headquarter: headquarter, role: "owner").save
      end

      it { is_expected.to permit_actions(%i(create)) }
    end

    context "being a member of the headquarter" do
      before do
        HeadquarterTeamAdder.new(user: user, headquarter: headquarter).save
      end

      it { is_expected.to permit_actions(%i(create)) }
    end

    context "being a spectator of the headquarter" do
      before do
        HeadquarterTeamAdder.new(user: user, headquarter: headquarter, invited: true).save
      end

      it { is_expected.to forbid_actions(%i(create)) }
    end
  end

  describe "when project is subject" do
    let(:user) { create(:user) }
    let(:project) { create(:project) }
    let(:headquarter) { project.headquarter }

    subject { described_class.new(user, project) }

    include_examples "being_a_visitor"

    context "being the owner of headquarter" do
      before do
        HeadquarterTeamAdder.new(headquarter: headquarter, user: user, role: "owner").save
      end

      it { is_expected.to permit_actions(%i(show)) }
    end

    context "being a member of the project" do
      before do
        ProjectTeamAdder.new(user: user, project: project).save
      end

      it { is_expected.to permit_actions(%i(show)) }
    end
  end
end
