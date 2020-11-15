require "rails_helper"

RSpec.describe User, type: :model do
  subject { build(:user) }

  describe "validations" do
    it { should have_secure_password }

    it { should validate_presence_of(:email)}

    it { should validate_uniqueness_of(:email).case_insensitive }

    it { should_not allow_value("abeidmama", "abeidm@em@.com").for(:email) }

    it { should allow_value("abeidmama@example.com", "abeidm@em.uk.com").for(:email) }

    it { should validate_length_of(:email).is_at_most(255) }

    it { should validate_presence_of(:name) }

    it { should validate_length_of(:name).is_at_most(255) }

    it "is should lowercase email before saving" do
      subject.email = subject.email.upcase
      subject.save!
      expect(subject.reload.email).to eq(subject.email.downcase)
    end

    it { should validate_length_of(:password).is_at_least(6) }
  end

  describe "before creating a new user" do
    it "is should set auth_token with Secure Random hash" do
      subject.auth_token = nil
      subject.save!
      expect(subject.reload.auth_token).to_not be_nil
    end
  end
end
