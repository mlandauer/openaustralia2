class CommentsController < ApplicationController
  def recent
    @extra_keywords = "Recent comments"
    @title = "#{@extra_keywords} (OpenAustralia.org)"
    # TODO: There will be some limit on the number of comments shown here
    @comments = Comment.all(:order => "posted DESC")
  end
end
