class NewsController < ApplicationController
  def index
    @rss = true
    @news_menu_on = true
    @months = News.all.map{|p| [p.timestamp.year, p.timestamp.month]}.uniq.map{|a| Date.new(a[0],a[1],1)}.sort.reverse
    # HACK: Temporary
    @months << Date.new(2008,6,1)

    if params[:year] && params[:month]
      @subtitle = "May 2009"
      @extra_keywords = @subtitle
      @title = "#{@extra_keywords}: OpenAustralia news"

      posts = News.all
      @posts = [posts[1], posts[0]]
    else
      @title = "OpenAustralia news"
      @subtitle = "&nbsp;"
      @extra_keywords = @title
    
      @posts = News.all
    end
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
end
