class StaticController < ApplicationController
  def help
    @title = "Help"
    @extra_keywords = @title
  end
  
  def about
    @title = "About us"
    @extra_keywords = @title
  end
end
