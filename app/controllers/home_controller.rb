class HomeController < ApplicationController
  def index
    @title = "OpenAustralia.org: Are your Representatives and Senators working for you in Australia's Parliament?"
    @rss = true
  end
end
