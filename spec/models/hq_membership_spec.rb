require "rails_helper"

RSpec.describe HqMembership, type: :model do
  subject { build(:hq_membership) }

  describe "associations" do
    it { should belong_to(:user) }

    it { should belong_to(:headquarter) }
  end

  describe "validations" do
    it { should define_enum_for(:role).
      with_values(member: "member", owner: "owner").
      backed_by_column_of_type(:string)
    }

    it { should validate_uniqueness_of(:user).
        scoped_to(:headquarter_id).
        case_insensitive.
        with_message("is already on the HQ")
      }
  end
end
