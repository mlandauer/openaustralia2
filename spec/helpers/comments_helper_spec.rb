require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CommentsHelper do
  include CommentsHelper
  
  it "should display days and hours" do
    time_ago_in_words((3.days + 18.hours).ago).should == "3 days, 18 hours"
  end
  
  it "should handle singular/plural" do
    time_ago_in_words((1.day + 1.hour).ago).should == "1 day, 1 hour"    
  end
  
  it "should not display hours when exact number of days" do
    time_ago_in_words(6.days.ago).should == "6 days"
  end
  
  it "should display weeks when appropriate" do
    time_ago_in_words((3.weeks + 3.days).ago).should == "3 weeks, 3 days"
  end
  
  it "should display hours and minutes" do
    time_ago_in_words((5.hours + 1.minute).ago).should == "5 hours, 1 minute"
  end
  
  it "should display minutes and seconds" do
    time_ago_in_words((5.minutes + 1.second).ago).should == "5 minutes, 1 second"
  end
  
  it "should display only seconds" do
    time_ago_in_words(30.seconds.ago).should == "30 seconds"
  end
  
  it "should display one week correctly" do
    time_ago_in_words(1.week.ago).should == "1 week"
  end
  
  it "should just display the date if it's four weeks or longer ago" do
    Time.stub!(:now).and_return(Time.parse("Tue 15 Sep 2009 12:23:54 Sydney"))
    time_ago_in_words((3.weeks + 6.days).ago).should == "3 weeks, 6 days"
    time_ago_in_words(4.weeks.ago).should == "18 August 2009"
    time_ago_in_words((4.weeks + 1.day).ago).should == "17 August 2009"
  end
end
