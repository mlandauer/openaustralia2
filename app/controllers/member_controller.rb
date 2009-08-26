class MemberController < ApplicationController
  def representatives
    
    @titles = ["Representatives"]
    @members = Member.find_all_by_house(1)
  end
  
  def senators
    @titles = ["All Senators"]
    @members = Member.find_all_by_house(2)
  end

  def show
    if params[:name].gsub("_", " ") =~ /^(\S*) (\S*)$/
      @member = Member.first(:conditions => {:first_name => $~[1], :last_name => $~[2],
        :constituency => params[:constituency], :house => params[:house]})
      @titles = ["#{@member.formal_name}, #{@member.constituency}"]
    else
      # TODO: Add error handling here
    end
  end
end
