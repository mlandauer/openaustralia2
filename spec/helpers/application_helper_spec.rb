require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ApplicationHelper, "truncate" do
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

describe ApplicationHelper, "Add this widget" do
  include ApplicationHelper
  
  it "should create an 'add this' widget for the given url" do
    add_this("blah", 'http://foo.org/bar').should == "<a href=\"http://www.addthis.com/bookmark.php\" onclick=\"return addthis_sendto();\" onmouseout=\"addthis_close();\" onmouseover=\"return addthis_open(this, '', 'http://foo.org/bar', '');\">blah</a>"
  end
  
  it "should create the javascript for the 'add this' widget" do
    # TODO: Add support for addthis username
    add_this_javascript.should == <<-EOF
    <!-- ADDTHIS JAVASCRIPT BEGIN -->
    <script type="text/javascript">var addthis_pub = "foo";</script>
    <script src="http://s7.addthis.com/js/250/addthis_widget.js" type="text/javascript"></script>
    <!-- ADDTHIS JAVASCRIPT END -->
    EOF
  end
end