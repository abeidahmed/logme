RSpec.shared_examples "bad_request" do
  it "should return bad_request status" do
    expect(response).to be_bad_request
  end
end