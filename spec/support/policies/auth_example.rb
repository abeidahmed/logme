RSpec.shared_examples "being_a_visitor" do
  context "being a visitor" do
    let(:user) { nil }

    it "should raise error" do
      expect { subject }.to raise_error(Pundit::NotAuthorizedError)
    end
  end
end