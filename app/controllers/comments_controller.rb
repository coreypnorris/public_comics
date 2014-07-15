class CommentsController < ApplicationController
  before_filter :authenticate_user!, only: [:create]

  def new
    @comment = Comment.new(:parent_id => params[:comment_id])
    @parent_comment = Comment.find(params[:comment_id])
  end

  def create
    @issue = params[:issue_id] ? Issue.find(params[:issue_id]) : Comment.find(params[:comment_id]).commentable
    @parent_comment = Comment.find(params[:comment_id]) if params[:comment_id]
    @comment = Comment.build_from( @issue, current_user.id, comment_params[:body] )
    if @comment.save
      current_user.comments << @comment
      flash[:notice] = "Your comment has been submitted."
      if params[:issue_id]
        redirect_to :back
      elsif params[:comment_id]
        @comment.move_to_child_of(@parent_comment)
        redirect_to :back
      end
    else
      flash[:error] = "Something went wrong. Please try to save your comment again."
      redirect_to :back
    end
  end

private
  def comment_params
    params.require(:comment).permit(:body)
  end
end
