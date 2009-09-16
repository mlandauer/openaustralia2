class HomeController < ApplicationController
  def index
    @title = "OpenAustralia.org: Are your Representatives and Senators working for you in Australia's Parliament?"
    @rss = true
    
    # TODO: There will be some limit on the number of comments shown here
    @comments = Comment.all(:order => "posted DESC")
  end
end
