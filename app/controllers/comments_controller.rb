class CommentsController < ApplicationController
  def recent
    @title = "Recent comments"
    @extra_keywords = @title
    # TODO: There will be some limit on the number of comments shown here
    @comment = Comment.first
  end
end
