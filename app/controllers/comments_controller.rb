class CommentsController < ApplicationController
  def recent
    @title = "Recent comments"
    @extra_keywords = @title
  end
end
