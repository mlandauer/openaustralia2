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
    @rss = true
    @news_menu_on = true
    posts = News.all
    @months = News.all.map{|p| [p.timestamp.year, p.timestamp.month]}.uniq.map{|a| Date.new(a[0],a[1],1)}.sort.reverse
    # HACK: Temporary
    @months << Date.new(2008,6,1)
    
    @post = posts.find {|p| params[:year] == p.year_param && params[:month] == p.month_param && params[:day] == p.day_param && params[:title] == p.title_param }
    @extra_keywords = @post.title
    @title = "#{@extra_keywords}: OpenAustralia news"
  end
  
  def month
    @extra_keywords = "May 2009"
    @title = "#{@extra_keywords}: OpenAustralia news"
    @rss = true
    @news_menu_on = true
    @months = News.all.map{|p| [p.timestamp.year, p.timestamp.month]}.uniq.map{|a| Date.new(a[0],a[1],1)}.sort.reverse
    # HACK: Temporary
    @months << Date.new(2008,6,1)
    
    posts = News.all
    @posts = [posts[1], posts[0]]
  end
end
