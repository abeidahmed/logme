require "rails_helper"

RSpec.describe "PasswordResets", type: :request do
  describe "#create" do
    context "when the user is a member of Applog" do
      let(:user) { create(:user) }
      before do
        cookies[:auth_token] = "hello"
        post password_resets_url, params: { email: user.email.upcase }
      end

      it "should set password_reset_token" do
        expect(user.reload.password_reset_token).to_not be_nil
      end

      it "should set password_reset_sent_at to Time.zone.now" do
        expect(user.reload.password_reset_sent_at).to_not be_nil
      end

      it "should sent password_reset email" do
        expect(last_email.subject).to eq("Reset your password")
      end

      it "should delete the stored cookie" do
        expect(cookies[:auth_token]).to be_blank
      end
    end

    context "when the user is not a member of Applog" do
      before do
        post password_resets_url, params: { email: "helloworld@example.com" }
      end

      it "should return error message" do
        expect(json[:errors].keys).to match_array([:invalid])
      end

      include_examples "bad_request"
    end
  end

  describe "#update" do
    context "when the update request is valid" do
      let(:user) { create(:user, :forgot_password) }
      before do
        cookies[:auth_token] = "hello"
        patch password_reset_url(user.password_reset_token), params: { password: "hello1234", confirm_password: "hello1234" }
      end

      it "should update the user's password" do
        user.reload
        expect(user.authenticate("hello1234")).to be_truthy
      end

      it "should reset user's password_reset_fields" do
        user.reload
        expect(user.password_reset_sent_at).to be_nil
        expect(user.password_reset_token).to be_nil
      end

      it "should delete auth_token cookie" do
        expect(cookies[:auth_token]).to be_blank
      end
    end

    context "when the new password and confirm password do not match" do
      let(:user) { create(:user, :forgot_password) }
      before do
        patch password_reset_url(user.password_reset_token), params: { password: "hello1234", confirm_password: "hello123455" }
      end

      it "should not update the user's password" do
        user.reload
        expect(user.authenticate("hello1234")).to be_falsy
      end

      it "should return error message" do
        expect(json[:errors].keys).to match_array([:password_confirmation])
      end

      include_examples "bad_request"
    end

    context "when the password is blank" do
      let(:user) { create(:user, :forgot_password) }
      before do
        patch password_reset_url(user.password_reset_token), params: { password: "", confirm_password: "" }
      end

      it "should not update the user's password" do
        user.reload
        expect(user.authenticate("")).to be_falsy
      end

      it "should return error message" do
        expect(json[:errors].keys).to match_array([:password])
      end

      include_examples "bad_request"
    end

    context "when the password length is short" do
      let(:user) { create(:user, :forgot_password) }
      before do
        patch password_reset_url(user.password_reset_token), params: { password: "mama", confirm_password: "mama" }
      end

      it "should not update the user's password" do
        user.reload
        expect(user.authenticate("mama")).to be_falsy
      end

      it "should return error message" do
        expect(json[:errors].keys).to match_array([:password])
      end

      include_examples "bad_request"
    end

    context "when the password reset token has expired" do
      let(:user) { create(:user, :with_expired_token) }
      before do
        patch password_reset_url(user.password_reset_token), params: { password: "mamakane", confirm_password: "mamakane" }
      end

      it "should not update the user's password" do
        user.reload
        expect(user.authenticate("mamakane")).to be_falsy
      end
    end
  end
end
