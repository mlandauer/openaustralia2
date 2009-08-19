require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MemberController do
  it "should route the url correctly for individual senator pages" do
    params_from(:get, "/senator/eric_abetz/tasmania").should == {:controller => "member", :action => "senator", :name => "eric_abetz", :constituency => "tasmania"}
  end
  
  it "should lookup the correct person" do
    member = mock_model(Member)
    member.stub!(:name).and_return("Joe Smith")
    member.stub!(:constituency).and_return("Sydney")

    Member.should_receive(:first).with(:conditions => {:first_name => "joe", :last_name => "smith", :constituency => "sydney"}).and_return(member)
    get :senator, :name => "joe_smith", :constituency => "sydney"
  end
end
