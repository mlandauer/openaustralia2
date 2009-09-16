class StaticController < ApplicationController
  def help
    @extra_keywords = "Help"
    @title = "#{@extra_keywords} (OpenAustralia.org)"
  end
  
  def about
    @extra_keywords = "About us"
    @title = "#{@extra_keywords} (OpenAustralia.org)"
  end
  
  def contact
    @extra_keywords = "Contact OpenAustralia.org"
    @title = "#{@extra_keywords} (OpenAustralia.org)"
  end
  
  def link_to_us
    @extra_keywords = "Link to us"
    @title = "#{@extra_keywords} (OpenAustralia.org)"
  end
  
  def house_rules
    @extra_keywords = "House rules"
    @title = "#{@extra_keywords} (OpenAustralia.org)"
  end
end
