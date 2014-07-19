class VotesController < ApplicationController

  def new
    @comment = Comment.find(params[:comment_id])
    @page = Page.find(params[:page_id])
    if current_user.voted_for? @comment
      @comment.unliked_by current_user
      @comment.undisliked_by current_user
      redirect_to issue_page_path(@page.issue, @page)
    elsif params[:kind] == "upvote"
      @comment.liked_by current_user
      redirect_to issue_page_path(@page.issue, @page)
    elsif params[:kind] == "downvote"
      @comment.downvote_from current_user
      redirect_to issue_page_path(@page.issue, @page)
    end
  end

end
