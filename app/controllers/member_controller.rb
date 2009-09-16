class MemberController < ApplicationController
  def representatives
    @extra_keywords = "Representatives"
    @title = "#{@extra_keywords} (OpenAustralia.org)"
    @members = Member.find_all_by_house(1)
  end
  
  def senators
    @extra_keywords = "All Senators"
    @title = "#{@extra_keywords} (OpenAustralia.org)"
    @members = Member.find_all_by_house(2)
  end

  def show
    if params[:m]
      member = Member.find(params[:m].to_i)
      redirect_to :name => member.name_param, :constituency => member.constituency_param
    elsif params[:name].gsub("_", " ") =~ /^(\S*) (\S*)$/
      @member = Member.first(:conditions => {:first_name => $~[1], :last_name => $~[2],
        :constituency => params[:constituency], :house => params[:house]})
      @extra_keywords = "#{@member.formal_name}, #{@member.constituency}"
      @title = "#{@extra_keywords} (OpenAustralia.org)"
    else
      # TODO: Add error handling here
    end
  end
end
