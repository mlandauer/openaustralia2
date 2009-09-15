class StaticController < ApplicationController
  def show
    if params[:path] = ["help"]
      @title = "Help"
      @extra_keywords = @title
    end
    render :action => params[:path].join('/')
  end
end
