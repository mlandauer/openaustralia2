class StaticController < ApplicationController
  def help
    @title = "Help"
    @extra_keywords = @title
  end
end
