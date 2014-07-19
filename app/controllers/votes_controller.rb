class VotesController < ApplicationController
  before_filter :authenticate_user!, only: [:new]

  def new
    @comment = Comment.find(params[:comment_id])
    @page = Page.find(params[:page_id])

    if @comment.user == current_user
      redirect_to :back
    end

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
