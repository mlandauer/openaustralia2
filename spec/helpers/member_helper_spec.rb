require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MemberHelper do
  it "should have access to a nice and simple date formatter" do
    Date.new(2008, 11, 5).to_formatted_s(:simple).should == "5 November 2008"
  end
end
