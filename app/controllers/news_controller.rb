class NewsController < ApplicationController
  def index
    @title = "OpenAustralia news"
    @extra_keywords = @title
    @rss = true
    
    @posts = News.all
  end
end
