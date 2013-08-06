require 'spec_helper'

describe User do
  let(:user) { User.new }
  it "should use name as a string" do
    user.name = "Kristian"
    user.to_s == user.name
  end

  it { should have_one(:podcast) }
  it { should have_many(:episodes).through(:podcast) }

  describe "#limit" do
    it "should be 5 if not subscribed" do
      user.subscribed = false
      user.limit.should == 5
    end

    it "should be nil if subscribed" do
      user.subscribed = true
      user.limit.should == nil
    end
  end
end
