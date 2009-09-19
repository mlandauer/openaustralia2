class MemberController < ApplicationController
  def index
    if params[:o].nil? || params[:o] == "l"
      @order = "last_name"
    elsif params[:o] == "f"
      @order = "first_name"
    elsif params[:o] == "p"
      @order = "party"
    elsif params[:o] == "c"
      @order = "constituency"
    else
      raise "unsupported order"
    end

    if params[:house] == 1
      @extra_keywords = "Representatives"
    elsif params[:house] == 2
      @extra_keywords = "All Senators"
    else
      raise "Unsupported house"
    end
    @title = "#{@extra_keywords} (OpenAustralia.org)"
    @members = Member.all(:conditions => {:house => params[:house]}, :order => @order)

    if params[:house] == 1
      render :representatives
    elsif params[:house] == 2
      render :senators
    end
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
