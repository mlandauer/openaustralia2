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
    @news_menu_on = true
  end
  
  def show
    @extra_keywords = "Our new home on Facebook"
    @title = "#{@extra_keywords}: OpenAustralia news"
    @rss = true
    @news_menu_on = true
    @months = News.all.map{|p| [p.timestamp.year, p.timestamp.month]}.uniq.map{|a| Date.new(a[0],a[1],1)}.sort.reverse
    # HACK: Temporary
    @months << Date.new(2008,6,1)
    
    @post = News.all[0]
  end
end
