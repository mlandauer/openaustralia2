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
  
  def link_to_us
    @title = "Link to us"
    @extra_keywords = @title
  end
  
  def house_rules
    @title = "House rules"
    @extra_keywords = @title
  end
end
