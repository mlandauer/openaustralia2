require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Member do
  fixtures :member, :moffice

  it "should return a list of ministerial positions" do
    member(:eric_abetz).current_minister_positions.should == ["Deputy Leader of the Opposition in the Senate",
        "Shadow Minister for Innovation, Industry, Science and Research"]
  end
end
