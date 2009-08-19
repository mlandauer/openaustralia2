require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MemberController do
  it "should route the url correctly for individual senator pages" do
    params_from(:get, "/senator/eric_abetz/tasmania").should == {:controller => "member", :action => "show",
      :name => "eric_abetz", :constituency => "tasmania", :house => 2}
  end
  
  it "should lookup the correct person" do
    member = mock_model(Member)
    member.stub!(:formal_name).and_return("Senator Joe Smith")
    member.stub!(:constituency).and_return("Sydney")

    Member.should_receive(:first).with(:conditions => {:first_name => "joe", :last_name => "smith", :constituency => "sydney", :house => "2"}).and_return(member)
    get :show, :name => "joe_smith", :constituency => "sydney", :house => 2
  end
end
