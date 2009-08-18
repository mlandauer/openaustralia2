class MemberController < ApplicationController
  def representatives
    @title = "Representatives"
    @members = Member.find_all_by_house(1)
  end
  
  def senators
    @title = "All Senators"
    @members = Member.find_all_by_house(2)
  end
  
  def senator
    @title = "Senator Eric Abetz, Tasmania"
  end
end
