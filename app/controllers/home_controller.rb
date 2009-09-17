class HomeController < ApplicationController
  def index
    @title = "OpenAustralia.org: Are your Representatives and Senators working for you in Australia's Parliament?"
    @rss = true
    
    # TODO: There will be some limit on the number of comments shown here
    @comments = Comment.all(:order => "posted DESC")
    # Only show the first 2 news items
    @posts = News.all[0..1]
  end
end
