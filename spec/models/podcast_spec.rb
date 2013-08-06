require 'spec_helper'

describe Podcast do

  it { should belong_to(:user) }
  it { should have_many(:episodes) }
  it "should set the right attributes on init" do
    user = User.new(name: "Kristian")
    podcast = Podcast.create(user: user)
    podcast.name.should == "Kristian's podcast"
  end

  it "should have the right name with no user (?)" do
    podcast = Podcast.new
    podcast.name.should == "Podcast"
  end
end
