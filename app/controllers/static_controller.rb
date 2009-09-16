class StaticController < ApplicationController
  def help
    @title = "Help"
    @extra_keywords = @title
  end
  
  def about
    @title = "About us"
    @extra_keywords = @title
  end
  
  def contact
    @title = "Contact OpenAustralia.org"
    @extra_keywords = @title
  end
  
  def linktous
    @title = "Link to us"
    @extra_keywords = @title
  end
end
