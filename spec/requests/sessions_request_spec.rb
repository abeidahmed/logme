require "rails_helper"

RSpec.describe "Sessions", type: :request do
  describe "#create" do
    context "when the signin in valid" do
      let(:user) { create(:user) }
      before do
        post sessions_url, params: { email: user.email, password: user.password }
      end

      it "should signin the user" do
        expect(cookies[:auth_token]).to eq(user.auth_token)
      end
    end

    context "when the signin is invalid" do
      let(:user) { create(:user) }
      before do
        post sessions_url, params: { email: "hello@ex.com", password: user.password }
      end

      it "should return error" do
        expect(json.dig(:errors, :invalid)).to_not be_nil
      end

      include_examples "bad_request"
    end
  end

  describe "#destroy" do
    context "when the user is signed in" do
      let(:user) { create(:user) }
      before do
        login(user)
        delete session_url("hello")
      end

      it "should logout the user" do
        expect(cookies[:auth_token]).to be_blank
      end
    end
  end
end
