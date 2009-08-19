class MemberController < ApplicationController
  def representatives
    @title = "Representatives"
    @members = Member.find_all_by_house(1)
  end
  
  def senators
    @title = "All Senators"
    @members = Member.find_all_by_house(2)
  end

  def representative
    if params[:name].gsub("_", " ") =~ /^(\S*) (\S*)$/
      @member = Member.first(:conditions => {:first_name => $~[1], :last_name => $~[2], :constituency => params[:constituency]})
      @title = "#{@member.name} MP, #{@member.constituency}"
    else
      # TODO: Add error handling here
    end
    render :show
  end
  
  def senator
    if params[:name].gsub("_", " ") =~ /^(\S*) (\S*)$/
      @member = Member.first(:conditions => {:first_name => $~[1], :last_name => $~[2], :constituency => params[:constituency]})
      @title = "Senator #{@member.name}, #{@member.constituency}"
    else
      # TODO: Add error handling here
    end
    render :show
  end
end
