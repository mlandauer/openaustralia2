class MemberController < ApplicationController
  include ActionView::Helpers::TextHelper
  
  def representatives
    @titles = ["Representatives"]
    @title = @titles.map{|t| truncate(t, :length => 38)}.join(': ')
    @extra_keywords = @titles[0..1].map{|t| truncate(t, :length => 38)}.join(': ')
    @members = Member.find_all_by_house(1)
  end
  
  def senators
    @titles = ["All Senators"]
    @title = @titles.map{|t| truncate(t, :length => 38)}.join(': ')
    @extra_keywords = @titles[0..1].map{|t| truncate(t, :length => 38)}.join(': ')
    @members = Member.find_all_by_house(2)
  end

  def show
    if params[:name].gsub("_", " ") =~ /^(\S*) (\S*)$/
      @member = Member.first(:conditions => {:first_name => $~[1], :last_name => $~[2],
        :constituency => params[:constituency], :house => params[:house]})
      @titles = ["#{@member.formal_name}, #{@member.constituency}"]
      @title = @titles.map{|t| truncate(t, :length => 38)}.join(': ')
      @extra_keywords = @titles[0..1].map{|t| truncate(t, :length => 38)}.join(': ')
    else
      # TODO: Add error handling here
    end
  end
end
