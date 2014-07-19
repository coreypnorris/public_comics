class VotesController < ApplicationController

  def new
    @comment = Comment.find(params[:comment_id])
    @page = Page.find(params[:page_id])
    if current_user.voted_for? @comment
      @comment.unliked_by current_user
      @comment.undisliked_by current_user
    elsif params[:kind] == "upvote"
      @comment.liked_by current_user
    elsif params[:kind] == "downvote"
      @comment.downvote_from current_user
    end
    respond_to do |format|
      format.html { redirect_to issue_page_path(@page.issue, @page) }
      format.js
    end
  end

end
