require "rails_helper"

RSpec.describe Project, type: :model do
  subject { build(:project) }

  describe "associations" do
    it { should belong_to(:headquarter) }

    it { should have_many(:users) }

    it { should have_many(:project_memberships) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }

    it { should validate_length_of(:name).is_at_most(255) }

    it { should validate_length_of(:url).is_at_most(255) }

    it { should validate_presence_of(:subdomain) }

    it { should validate_length_of(:subdomain).is_at_most(63) }

    it { should validate_uniqueness_of(:subdomain).case_insensitive }

    it { should validate_length_of(:description).is_at_most(500) }

    it { should allow_value(
      "http://gmail.com/",
      "https://gmail.com/",
      "https://domain.gmail.com",
      "http://domain.gmail.com"
    ).for(:url) }

    it { should_not allow_value("http://gmail.com test", "https://gmail.com test").for(:url) }
  end

  describe "before save" do
    it "should lowercase url" do
      url = "https://google.com"
      project = create(:project, url: url.upcase)
      expect(project.reload.url).to eq(url)
    end

    it "should lowercase subdomain" do
      subdomain = "helloworld"
      project = create(:project, subdomain: subdomain.upcase)
      expect(project.reload.subdomain).to eq(subdomain)
    end
  end
end
