class DebateController < ApplicationController
  def show
    @title = "Second Reading: 14 May 2009: House debates"
    @extra_keyword = "Second Reading: 14 May 2009"
    # Hack to deal with not entirely consistent behaviour of "Debates" menu
    @debates_menu_on = true
    render :layout => false
  end
end
