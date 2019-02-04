require "spec_helper"
require "signup"

describe Signup do
  describe "#save" do
    it "creates an account with one user" do
      # Setup
      account = stub_instance(Account)
      stub_instance(User)
      attributes = {email: "user@example.com", account_name: "Example"}
      signup = Signup.new(attributes)

      # Exercise
      result = signup.save

      # Verification
      expect(Account).to have_received(:create!).with(name: attributes[:account_name])
      expect(User).to have_received(:create!).with(account: account, email: attributes[:email])
      expect(result).to be(true)
    end
  end

  describe "#user" do
    it "returns the user created by #save" do
      # Setup
      stub_instance(Account)
      user = stub_instance(User)
      signup = Signup.new({email: "user@example.com", account_name: "Example"})
      signup.save

      # Exercise
      result = signup.user

      # Verification
      expect(result).to eq(user)
    end
  end

  def stub_instance(model)
    double(model.name).tap do |instance|
      allow(model).to receive(:create!).and_return(instance)
    end
  end
end
