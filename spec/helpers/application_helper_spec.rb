require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ApplicationHelper do
  include ApplicationHelper
  
  it "should not truncate text that is too short" do
    truncate("Hello, how are you?", :length => 30).should == "Hello, how are you?"
  end
  
  it "should truncate text that is too long" do
    truncate("Hello, how are you?", :length => 10).should == "Hello, ..."
  end
  
  it "should truncate text only on spaces between words" do
    truncate("leave comments, post links.", :length => 20, :break_on_spaces => true).should == "leave comments,..."
  end
  
  it "should not be put off by newlines" do
    truncate("Hello\nThis is a newline", :length => 20).should == "Hello\nThis is a n..."
    truncate("Hello\nThis is a newline", :length => 20, :break_on_spaces => true).should == "Hello\nThis is a..."
  end
end
