require "rails_helper"

RSpec.feature "Signups", type: :feature do
  describe "when signup request is valid" do
    it "should sign up the user" do
      sign_up

      expect(current_url).to eq(root_url)
    end
  end
end
