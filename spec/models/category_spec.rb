require 'spec_helper'

describe Category do
  it { should validate_presence_of(:name) }

  it "should accept a nested category" do
    category = Category.create(name: "Movies")
    sub = category.categories.create(name: "Star Wars")
    category.categories.first.should == sub
    sub.category_id.should == category.id
  end
end
