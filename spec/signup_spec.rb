require "spec_helper"
require "signup"

describe Signup do
  describe "#save" do
    it "creates an account with one user" do
      # Setup
      attributes = {email: "user@example.com", account_name: "Example"}
      account = double("account")
      allow(Account).to receive(:create!).and_return(account)
      user = double("user")
      allow(User).to receive(:create!).and_return(user)
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
      attributes = {email: "user@example.com", account_name: "Example"}
      account = double("account")
      allow(Account).to receive(:create!).and_return(account)
      user = double("user")
      allow(User).to receive(:create!).and_return(user)
      signup = Signup.new(attributes)
      signup.save

      # Exercise
      result = signup.user

      # Verification
      expect(result).to eq(user)
    end
  end
end
