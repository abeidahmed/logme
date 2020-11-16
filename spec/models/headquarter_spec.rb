require "rails_helper"

RSpec.describe Headquarter, type: :model do
  describe "associations" do
    it { should have_many(:users) }

    it { should have_many(:hq_memberships) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }

    it { should validate_length_of(:name).is_at_most(255) }

    it { should validate_length_of(:description).is_at_most(500) }
  end
end
