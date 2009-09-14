class NewsController < ApplicationController
  def index
    @title = "OpenAustralia news"
    @extra_keywords = @title
    @rss = true
  end
end
