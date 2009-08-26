require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TextObject do
  it "should convert links to nofollow" do
    t = TextObject.new
    t.should_receive(:body).and_return('<p>Hello, <a href="http://foo">how</a> are you?</p>')
    t.display_body.should == '<p>Hello, <a href="http://foo" rel="nofollow">how</a> are you?</p>'
  end
end
