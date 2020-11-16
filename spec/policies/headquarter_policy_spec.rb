require "rails_helper"

RSpec.describe HeadquarterPolicy, type: :policy do
  let(:user) { create(:user) }
  let(:headquarter) { Headquarter.new }

  subject { described_class.new(user, headquarter) }

  include_examples "being_a_visitor"

  context "being a logged in user only" do
    it { is_expected.to permit_actions(%i(create)) }
  end
end
