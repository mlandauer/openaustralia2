class NewsController < ApplicationController
  def index
    @title = "OpenAustralia news"
    @extra_keywords = @title
    @rss = true
    
    @posts = News.all
    
    # Figure out the months that posts appear in
    @months = @posts.map{|p| [p.timestamp.year, p.timestamp.month]}.uniq.map{|a| Date.new(a[0],a[1],1)}.sort.reverse
    
    # HACK: Temporary
    @months << Date.new(2008,6,1)
  end
end
