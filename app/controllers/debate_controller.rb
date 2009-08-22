class DebateController < ApplicationController
  def show
    @title = "Second Reading: 14 May 2009: House debates"
    @extra_keyword = "Second Reading: 14 May 2009"
    render :layout => false
  end
end
