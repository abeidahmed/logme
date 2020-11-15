require "rails_helper"

RSpec.describe "Users", type: :request do
  describe "#create" do
    context "when the signup is valid" do
      before do
        post users_url, params: { user: { name: "John Doe", email: "hello@example.com", password: "secretttt" } }
      end

      it "should create the user" do
        expect(User.count).to eq(1)
      end

      it "should login user" do
        expect(cookies[:auth_token]).to eq(User.first.auth_token)
      end
    end

    context "when the signup is invalid" do
      before do
        post users_url, params: { user: { name: "Abeid Ahmed", email: "", password: "secretttt" } }
      end

      it "should return error" do
        expect(json.dig(:errors, :email)).to_not be_nil
      end

      include_examples "bad_request"
    end
  end
end
